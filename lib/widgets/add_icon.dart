import 'package:filesync/dialogs/folder_prompt.dart';
import 'package:filesync/models/broadcasting_folder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Adds a broadcast or a discovery.
class AddIcon extends ConsumerWidget {
  /// Creates a new "Add" icon instance.
  const AddIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => IconButton(
    onPressed: () async {
      (String, String)? result = await FolderPromptDialog.prompt(context);
      if (result != null && result.$1 != '' && result.$2 != '') {
        ref
            .read(broadcastingFolderListProvider.notifier)
            .add(BroadcastingFolder(result.$1, result.$2));
      }
    },
    icon: const Icon(Icons.add),
    tooltip: 'Add folder',
  );
}
