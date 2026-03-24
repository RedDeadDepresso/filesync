import 'package:filesync/models/broadcasting_folder.dart';
import 'package:filesync/widgets/broadcasting_folder_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Displays the current broadcasts.
class BroadcastingFoldersPageWidget extends ConsumerWidget {
  /// Creates a new broadcasts page widget instance.
  const BroadcastingFoldersPageWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<BroadcastingFolder> folders = ref.watch(
      broadcastingFolderListProvider,
    );
    return Center(
      child: ListView(
        padding: const EdgeInsets.all(10),
        shrinkWrap: folders.isEmpty,
        children: [
          if (folders.isEmpty)
            const Text(
              'Currently not broadcasting any folder.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontStyle: FontStyle.italic,
              ),
            ),
          for (BroadcastingFolder folder in folders)
            BroadcastingFolderWidget(folder: folder),
        ],
      ),
    );
  }
}
