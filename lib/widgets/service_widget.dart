import 'package:bonsoir/bonsoir.dart';
import 'package:filesync/models/app_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServiceWidget extends ConsumerWidget {
  final BonsoirService service;
  final void Function()? onTap;

  const ServiceWidget({super.key, required this.service, this.onTap});

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
    return Card(
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          leading: Icon(iconData),
          title: Text(service.name),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.chevron_right),
          isThreeLine: true,
        ),
      ),
    );
  }
}
