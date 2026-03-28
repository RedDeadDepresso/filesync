import 'package:filesync/models/database.dart';
import 'package:filesync/widgets/add_icon.dart';
import 'package:filesync/widgets/broadcasting_folder_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Displays the current broadcasts.
class BroadcastingFoldersPageWidget extends ConsumerWidget {
  /// Creates a new broadcasts page widget instance.
  const BroadcastingFoldersPageWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foldersAsync = ref.watch(broadcastingFoldersProvider);
    final folders = foldersAsync.value;
    return Scaffold(
      appBar: AppBar(
        title: Text("Broadcasting Folders"),
        actions: [const AddIcon()],
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(10),
          shrinkWrap: folders == null || folders.isEmpty,
          children: [
            if (folders == null)
              const Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(),
              )
            else if (folders.isEmpty)
              const Text(
                'Currently not broadcasting any folder.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontStyle: FontStyle.italic,
                ),
              )
            else
              for (BroadcastingFolder folder in folders)
                BroadcastingFolderWidget(folder: folder),
          ],
        ),
      ),
    );
  }
}
