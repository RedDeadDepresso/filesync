import 'dart:io';

import 'package:bonsoir/bonsoir.dart';
import 'package:filesync/providers/remote_folders_provider.dart';
import 'package:filesync/widgets/loading_card.dart';
import 'package:filesync/widgets/remote_folder_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NearbyDevicePageWidget extends ConsumerStatefulWidget {
  final BonsoirService service;

  const NearbyDevicePageWidget({super.key, required this.service});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NearbyDevicePageWidgetState();
}

class _NearbyDevicePageWidgetState
    extends ConsumerState<NearbyDevicePageWidget> {
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
    final folder = getNotifier().getRemoteFolder(folderId);
    if (folder == null) return;
    if (Platform.isWindows) {
      Process.run('explorer', [folder.path]);
    } else if (Platform.isMacOS) {
      Process.run('open', [folder.path]);
    } else if (Platform.isLinux) {
      Process.run('xdg-open', [folder.path]);
    }
  }

  RemoteFoldersNotifier getNotifier() {
    return ref.read(remoteFoldersProvider(widget.service.host!).notifier);
  }

  Future<void> unlinkSelectedFolders() async {
    await getNotifier().unlinkMulti(selectedFolderIds);
    selectedFolderIds.clear();
  }

  @override
  Widget build(BuildContext context) {
    final asyncRemoteFolders = ref.watch(
      remoteFoldersProvider(widget.service.host!),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.service.name),
        actions: [
          IconButton(
            onPressed: () async => await getNotifier().refresh(),
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: asyncRemoteFolders.when(
          data: (remoteFolders) => ListView(
            children: [
              for (var remoteFolder in remoteFolders.values)
                RemoteFolderWidget(
                  remoteFolder: remoteFolder,
                  isSelected: selectedFolderIds.contains(remoteFolder.id),
                  onChanged: (add) =>
                      updateSelectedFolder(remoteFolder.id, add),
                  onSync: () async => await getNotifier().sync(remoteFolder.id),
                  onView: () async => await view(remoteFolder.id),
                  onLink: () async => await getNotifier().link(remoteFolder.id),
                  onUnlink: () async =>
                      await getNotifier().unlink(remoteFolder.id),
                ),
            ],
          ),
          error: (err, stack) => Text('$err'),
          loading: () => LoadingCard(text: "Loading remote folders..."),
        ),
      ),
      persistentFooterButtons: [
        OutlinedButton.icon(
          icon: const Icon(Icons.remove),
          onPressed: selectedFolderIds.isEmpty ? null : unlinkSelectedFolders,
          label: const Text("Unlink"),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.red,
            side: selectedFolderIds.isEmpty
                ? null
                : const BorderSide(color: Colors.red),
          ),
        ),
        FilledButton.icon(
          icon: const Icon(Icons.sync),
          onPressed: selectedFolderIds.isEmpty
              ? null
              : () async => await getNotifier().syncMulti(selectedFolderIds),
          label: const Text("Sync"),
        ),
      ],
    );
  }
}
