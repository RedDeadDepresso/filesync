import 'dart:io';

import 'package:drift/drift.dart';
import 'package:filesync/dialogs/folder_prompt.dart';
import 'package:filesync/models/database.dart';
import 'package:filesync/providers/database_provider.dart';
import 'package:filesync/providers/shared_folders_provider.dart';
import 'package:filesync/widgets/add_icon.dart';
import 'package:filesync/widgets/loading_card.dart';
import 'package:filesync/widgets/shared_folder_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SharedFoldersPageWidget extends ConsumerStatefulWidget {
  const SharedFoldersPageWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      SharedFoldersPageWidgetState();
}

class SharedFoldersPageWidgetState
    extends ConsumerState<SharedFoldersPageWidget> {
  final Set<String> selectedFolderIds = {};

  void updateSelectedFolder(String folderId, bool? add) {
    if (add == true) {
      selectedFolderIds.add(folderId);
    } else {
      selectedFolderIds.remove(folderId);
    }
    setState(() {
      selectedFolderIds;
    });
  }

  Future<void> view(String folderId) async {
    final db = ref.read(databaseProvider);
    final folder = await db.managers.sharedFolders
        .filter((f) => f.id.equals(folderId))
        .getSingle();
    if (Platform.isWindows) {
      Process.run('explorer', [folder.path]);
    } else if (Platform.isMacOS) {
      Process.run('open', [folder.path]);
    } else if (Platform.isLinux) {
      Process.run('xdg-open', [folder.path]);
    }
  }

  Future<void> edit(String folderId) async {
    final db = ref.read(databaseProvider);
    final folder = await db.managers.sharedFolders
        .filter((f) => f.id.equals(folderId))
        .getSingle();

    if (!mounted) return;

    final result = await FolderPromptDialog.prompt(
      context,
      "Edit Folder",
      initialName: folder.name,
      initialPath: folder.path,
    );
    if (result != null && result.$1 != '' && result.$2 != '') {
      final db = ref.read(databaseProvider);
      await db.managers.sharedFolders
          .filter((f) => f.id.equals(folder.id))
          .update((f) => f(name: Value(result.$1), path: Value(result.$2)));
    }
  }

  Future<void> delete(String folderId) async {
    final db = ref.read(databaseProvider);
    await db.managers.sharedFolders
        .filter((k) => k.id.equals(folderId))
        .delete();
    selectedFolderIds.remove(folderId);
  }

  Future<void> deleteSelected() async {
    final db = ref.read(databaseProvider);
    await db.managers.sharedFolders
        .filter((k) => k.id.isIn(selectedFolderIds))
        .delete();
    selectedFolderIds.clear();
  }

  @override
  Widget build(BuildContext context) {
    final foldersAsync = ref.watch(sharedFoldersProvider);
    final folders = foldersAsync.value;
    return Scaffold(
      appBar: AppBar(title: Text("Shared Folders"), actions: [const AddIcon()]),
      body: folders == null
          ? LoadingCard(text: "Loading Shared Folders...")
          : Center(
              child: ListView(
                padding: const EdgeInsets.all(10),
                shrinkWrap: folders.isEmpty,
                children: [
                  if (folders.isEmpty)
                    const Text(
                      'Currently not sharing any folder.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    )
                  else
                    for (SharedFolder folder in folders)
                      SharedFolderWidget(
                        folder: folder,
                        isSelected: selectedFolderIds.contains(folder.id),
                        onChanged: (bool? value) =>
                            updateSelectedFolder(folder.id, value),
                        onView: () => view(folder.id),
                        onEdit: () => edit(folder.id),
                        onDelete: () => delete(folder.id),
                      ),
                ],
              ),
            ),
      persistentFooterButtons: [
        OutlinedButton.icon(
          icon: const Icon(Icons.remove),
          onPressed: selectedFolderIds.isEmpty ? null : deleteSelected,
          label: const Text("Delete"),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.red,
            side: selectedFolderIds.isEmpty
                ? null
                : const BorderSide(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
