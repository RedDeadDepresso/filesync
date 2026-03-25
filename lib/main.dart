import 'package:filesync/models/app_service.dart';
import 'package:filesync/models/server.dart';
import 'package:filesync/pages/broadcasting_folders.dart';
import 'package:filesync/pages/nearby_devices.dart';
import 'package:filesync/widgets/add_icon.dart';
import 'package:filesync/widgets/bottom_bar.dart';
import 'package:filesync/widgets/eager_initialization.dart';
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
  Widget build(BuildContext context) =>
      EagerInitialization(child: MaterialApp(home: _Scaffold()));
}

/// The app main scaffold.
class _Scaffold extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScaffoldState();
}

/// The scaffold state.
class _ScaffoldState extends State<_Scaffold> {
  /// The current page.
  late int currentPageIndex = 0;

  /// The page controller.
  late final PageController pageController = PageController(
    initialPage: currentPageIndex,
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('FileSync'),
      actions: currentPageIndex == 1 ? [AddIcon()] : [],
      centerTitle: false,
    ),
    body: PageView(
      controller: pageController,
      children: const [
        NearbyDevicesPageWidget(),
        BroadcastingFoldersPageWidget(),
      ],
    ),
    bottomNavigationBar: BottomBar(
      currentIndex: currentPageIndex,
      onPageChange: (index) {
        pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
        setState(() => currentPageIndex = index);
      },
    ),
  );

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
