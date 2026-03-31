import 'package:bonsoir/bonsoir.dart';
import 'package:filesync/providers/remote_folders_provider.dart';
import 'package:filesync/utils/open_folder.dart';
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

  RemoteFoldersNotifier getNotifier() {
    return ref.read(remoteFoldersProvider(widget.service.host!).notifier);
  }

  Future<void> view(String folderId) async {
    final folder = getNotifier().getRemoteFolder(folderId);
    if (folder == null) return;
    openFolder(folder.path);
  }

  Future<void> sync(String folderId) async {
    setState(() {
      selectedFolderIds.remove(folderId);
    });
    await getNotifier().sync(folderId);
  }

  Future<void> unLink(String folderId) async {
    setState(() {
      selectedFolderIds.remove(folderId);
    });
    await getNotifier().unlink(folderId);
  }

  Future<void> syncSelectedFolders() async {
    final folderIds = {...selectedFolderIds};
    setState(() {
      selectedFolderIds.clear();
    });
    await getNotifier().syncMulti(folderIds);
  }

  Future<void> unlinkSelectedFolders() async {
    final folderIds = {...selectedFolderIds};
    setState(() {
      selectedFolderIds.clear();
    });
    await getNotifier().unlinkMulti(folderIds);
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
      body: Center(
        child: asyncRemoteFolders.when(
          data: (remoteFolders) => remoteFolders.isEmpty
              ? const Text(
                  'The device is not sharing any folder.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.italic),
                )
              : ListView(
                  padding: EdgeInsets.all(10),
                  children: [
                    for (var remoteFolder in remoteFolders.values)
                      RemoteFolderWidget(
                        remoteFolder: remoteFolder,
                        isSelected: selectedFolderIds.contains(remoteFolder.id),
                        onChanged: (add) =>
                            updateSelectedFolder(remoteFolder.id, add),
                        onSync: () => sync(remoteFolder.id),
                        onView: () => view(remoteFolder.id),
                        onLink: () => getNotifier().link(remoteFolder.id),
                        onUnlink: () => unLink(remoteFolder.id),
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
          onPressed: selectedFolderIds.isEmpty ? null : syncSelectedFolders,
          label: const Text("Sync"),
        ),
      ],
    );
  }
}
