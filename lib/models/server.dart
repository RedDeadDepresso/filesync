import 'dart:convert';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:filesync/models/database.dart';
import 'package:filesync/utils/normalize_path.dart';
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
  final tempDir = await getApplicationCacheDirectory();
  await Isolate.spawn(_serverMain, [supportDir.path, tempDir.path]);
}

Future<(List<int>, int)> buildZip(
  String dirPath,
  Map<String, dynamic> excludePaths,
  String tempPath,
) async {
  final tempFile = File(
    p.join(tempPath, '${DateTime.now().millisecondsSinceEpoch}.zip'),
  );
  final encoder = ZipFileEncoder();
  try {
    encoder.create(tempFile.path);

    final baseDir = Directory(dirPath);
    await for (final entity in baseDir.list(recursive: true)) {
      if (entity is! File) continue;
      final relativePath = normalizePath(
        p.relative(entity.path, from: dirPath),
      );
      if (excludePaths.containsKey(relativePath)) continue;
      await encoder.addFile(entity, relativePath);
    }
    await encoder.close();

    final bytes = await tempFile.readAsBytes(); // read fully before delete
    return (bytes, bytes.length);
  } finally {
    await Future.delayed(const Duration(milliseconds: 100));
    try {
      await tempFile.delete();
    } catch (_) {}
  }
}

void _serverMain(List args) async {
  final supportPath = args[0] as String;
  final tempPath = args[1] as String;

  final dbFile = File(p.join(supportPath, "my_database.sqlite"));

  final db = AppDatabase(NativeDatabase(dbFile));

  var app = Router();

  // Define a simple route
  app.get('/shared-folders', (Request request) async {
    final folders = await db.managers.sharedFolders.get();
    final data = {for (var f in folders) f.id: f.name};
    return Response.ok(
      jsonEncode(data),
      headers: {'content-type': 'application/json'},
    );
  });

  app.post('/shared-folders/<id>/sync', (Request request, String id) async {
    try {
      final payload = await request.readAsString();
      Map<String, dynamic> data = {};
      if (payload.isNotEmpty) data = jsonDecode(payload);

      final folder = await db.managers.sharedFolders
          .filter((f) => f.id.equals(id))
          .getSingle();

      final (bytes, fileSize) = await buildZip(folder.path, data, tempPath);

      return Response.ok(
        bytes, // shelf accepts List<int> directly
        headers: {
          'Content-Type': 'application/zip',
          'Content-Disposition': 'attachment; filename="$id.zip"',
          'Content-Length': fileSize.toString(),
        },
      );
    } catch (e, st) {
      print("SERVER ERROR: $e\n$st");
      return Response.internalServerError(body: e.toString());
    }
  });
  await shelf_io.serve(app.call, InternetAddress.anyIPv4, 4000);
}
