import 'dart:convert';
import 'dart:io';

import 'package:filesync/models/database.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';
import 'dart:isolate';

void startBackgroundServer() async {
  // This runs the server on a different CPU core
  await Isolate.spawn(_serverMain, "Start Server");
}

// This function MUST be a top-level function or static
void _serverMain(String message) async {
  var app = Router();

  // Define a simple route
  app.get('/broadcasting-folders', (Request request) async {
    final folders = await db.managers.broadcastingFolders.get();
    final data = folders.map((f) => {"name": f.name, "path": f.path});
    return Response.ok(
      jsonEncode(data),
      headers: {'content-type': 'application/json'},
    );
  });

  await shelf_io.serve(app.call, InternetAddress.anyIPv4, 4000);
}
