import 'dart:convert';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:filesync/models/database.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';
import 'dart:isolate';
import 'package:archive/archive_io.dart';
import 'dart:async';

void startBackgroundServer() async {
  final supportDir = await getApplicationSupportDirectory();
  final tempDir = await getApplicationSupportDirectory();
  await Isolate.spawn(_serverMain, [supportDir.path, tempDir.path]);
}

Stream<List<int>> streamZip(
  String dirPath,
  Map<String, dynamic> excludePaths,
) async* {
  final archive = Archive();
  final baseDir = Directory(dirPath);

  await for (final entity in baseDir.list(recursive: true)) {
    if (entity is! File) continue;

    final relativePath = p.relative(entity.path, from: dirPath);
    if (excludePaths.containsKey(relativePath)) continue;

    final bytes = await entity.readAsBytes();
    archive.addFile(ArchiveFile(relativePath, bytes.length, bytes));
  }

  final encoder = ZipEncoder();
  final output = OutputMemoryStream();
  encoder.encode(archive, output: output);
  yield output.getBytes(); // yields complete valid ZIP
}

// This function MUST be a top-level function or static
void _serverMain(List args) async {
  final supportPath = args[0] as String;

  final dbFile = File(p.join(supportPath, "my_database.sqlite"));

  final db = AppDatabase(NativeDatabase(dbFile));

  var app = Router();

  // Define a simple route
  app.get('/broadcasting-folders', (Request request) async {
    final folders = await db.managers.broadcastingFolders.get();
    final data = {
      for (var f in folders) f.id: {"name": f.name, "path": f.path},
    };
    return Response.ok(
      jsonEncode(data),
      headers: {'content-type': 'application/json'},
    );
  });

  app.post('/broadcasting-folders/<id>/sync', (
    Request request,
    String id,
  ) async {
    try {
      final payload = await request.readAsString();
      Map<String, dynamic> data = {};
      if (payload.isNotEmpty) {
        data = jsonDecode(payload);
      }

      final folder = await db.managers.broadcastingFolders
          .filter((f) => f.id.equals(id))
          .getSingle();

      final stream = streamZip(folder.path, data);

      return Response.ok(
        stream,
        headers: {
          'Content-Type': 'application/zip',
          'Content-Disposition': 'attachment; filename="$id.zip"',
        },
      );
    } catch (e, st) {
      print("SERVER ERROR: $e\n$st");
      return Response.internalServerError(body: e.toString());
    }
  });

  await shelf_io.serve(app.call, InternetAddress.anyIPv4, 4000);
}
