import 'package:filesync/models/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Allows to display a discovered service.
class SharedFolderWidget extends ConsumerWidget {
  /// The discovered service.
  final SharedFolder folder;

  /// The trailing widget.
  final Widget? trailing;

  /// Creates a new service widget.
  const SharedFolderWidget({super.key, required this.folder, this.trailing});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.folder),
        title: Text(folder.name),
        subtitle: Text(folder.path),
        trailing: trailing,
        isThreeLine: true,
      ),
    );
  }
}
