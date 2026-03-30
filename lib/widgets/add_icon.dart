import 'package:filesync/dialogs/folder_prompt.dart';
import 'package:filesync/providers/database_provider.dart';
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
        final db = ref.watch(databaseProvider);
        db.managers.sharedFolders.create(
          (f) => f(name: result.$1, path: result.$2),
        );
      }
    },
    icon: const Icon(Icons.add),
    tooltip: 'Add folder',
  );
}
