import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:filesync/models/database.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';
import 'dart:isolate';

void startBackgroundServer() async {
  // This runs the server on a different CPU core
  final dir = await getApplicationSupportDirectory();
  await Isolate.spawn(_serverMain, dir.path);
}

// This function MUST be a top-level function or static
void _serverMain(String dbPath) async {
  var app = Router();
  final db = AppDatabase(NativeDatabase(File('$dbPath/my_database.sqlite')));
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

  await shelf_io.serve(app.call, InternetAddress.anyIPv4, 4000);
}
