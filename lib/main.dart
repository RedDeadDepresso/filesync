import 'package:filesync/models/app_service.dart';
import 'package:filesync/models/server.dart';
import 'package:filesync/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// This file is the entry point of the Bonsoir example project.
/// The full source code is available here :
/// https://github.com/Skyost/Bonsoir/tree/main/packages/bonsoir/example.
///
/// Feel free to check the available code snippets as well :
/// https://bonsoir.skyost.eu/docs#getting-started.

/// Plugin's main method.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DefaultAppService.initialize();
  startBackgroundServer();
  runApp(const ProviderScope(child: FileSyncMainWidget()));
}

/// The main widget.
class FileSyncMainWidget extends StatelessWidget {
  /// Creates a new main widget instance.
  const FileSyncMainWidget({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    routerConfig: router,
    theme: ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
      useMaterial3: true,
    ),
    darkTheme: ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.indigo,
      useMaterial3: true,
    ),
    themeMode: ThemeMode.system,
  );
}
