import 'package:bonsoir/bonsoir.dart';
import 'package:filesync/models/app_service.dart';
import 'package:filesync/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Allows to display a discovered service.
class ServiceWidget extends ConsumerWidget {
  /// The discovered service.
  final BonsoirService service;

  /// The trailing widget.
  final Widget? trailing;

  final bool navigate;

  /// Creates a new service widget.
  const ServiceWidget({
    super.key,
    required this.service,
    this.trailing,
    this.navigate = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String subtitle = '';
    for (MapEntry<String, String> entry in service.attributes.entries) {
      String key = entry.key;
      if (key == DefaultAppService.attributeOs) {
        key = 'OS';
      } else if (key == DefaultAppService.attributeUuid) {
        key = 'UUID';
      }
      subtitle += '${subtitle.isEmpty ? '' : ', '}$key : ${entry.value}';
    }

    if (service.host != null) {
      subtitle += '\nHost : ${service.host}, port : ${service.port}';
    }

    IconData iconData = switch (DefaultAppService.attributeOs) {
      'Android' => Icons.android,
      'iOS' || 'macOS' => Icons.apple,
      'Windows' || 'Linux' => Icons.monitor,
      _ => Icons.wifi,
    };

    if (navigate) {
      return Card(
        child: InkWell(
          onTap: () => context.push(Routes.nestedNearbyDevice, extra: service),
          child: ListTile(
            leading: Icon(iconData),
            title: Text(service.name),
            subtitle: Text(subtitle),
            trailing: trailing,
            isThreeLine: true,
          ),
        ),
      );
    } else {
      return Card(
        child: ListTile(
          leading: Icon(iconData),
          title: Text(service.name),
          subtitle: Text(subtitle),
          trailing: trailing,
          isThreeLine: true,
        ),
      );
    }
  }
}
