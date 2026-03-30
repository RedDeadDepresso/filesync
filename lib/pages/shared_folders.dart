import 'package:filesync/models/database.dart';
import 'package:filesync/providers/shared_folders_provider.dart';
import 'package:filesync/widgets/add_icon.dart';
import 'package:filesync/widgets/loading_card.dart';
import 'package:filesync/widgets/shared_folder_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SharedFoldersPageWidget extends ConsumerWidget {
  const SharedFoldersPageWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                      style: TextStyle(
                        color: Colors.black54,
                        fontStyle: FontStyle.italic,
                      ),
                    )
                  else
                    for (SharedFolder folder in folders)
                      SharedFolderWidget(folder: folder),
                ],
              ),
            ),
    );
  }
}
