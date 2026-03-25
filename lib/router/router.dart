import 'package:filesync/layout/layout_scaffold.dart';
import 'package:filesync/pages/broadcasting_folders.dart';
import 'package:filesync/pages/nearby_devices.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const String nearbyDevices = "/nearby-devices";
  static const String broadcastingFolders = "/broadcasting-folders";
}

final router = GoRouter(
  initialLocation: Routes.nearbyDevices,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          LayoutScaffold(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.nearbyDevices,
              builder: (context, state) => const NearbyDevicesPageWidget(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.broadcastingFolders,
              builder: (context, state) =>
                  const BroadcastingFoldersPageWidget(),
            ),
          ],
        ),
      ],
    ),
  ],
);
