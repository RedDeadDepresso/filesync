import 'package:flutter/material.dart';

/// An app page.
enum AppPage {
  /// "Discoveries" page.
  nearbyDevices(icon: Icons.smartphone, label: 'Nearby Devices'),

  /// "Broadcasts" page.
  broadcastingFolders(
    icon: Icons.wifi_tethering,
    label: 'Broadcasting Folders',
  );

  /// The page icon.
  final IconData icon;

  /// The page label.
  final String label;

  /// Creates a new app page instance.
  const AppPage({required this.icon, required this.label});
}
