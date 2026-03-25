import 'package:bonsoir/bonsoir.dart';
import 'package:filesync/widgets/service_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NearbyDevicePageWidget extends ConsumerWidget {
  final BonsoirService service;

  const NearbyDevicePageWidget({super.key, required this.service});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: ListView(
        padding: const EdgeInsets.all(10),
        children: [ServiceWidget(service: service)],
      ),
    );
  }
}
