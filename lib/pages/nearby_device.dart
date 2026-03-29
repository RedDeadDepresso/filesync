import 'package:bonsoir/bonsoir.dart';
import 'package:filesync/models/client.dart';
import 'package:filesync/models/database.dart';
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
  late Future<Map<String, Map<String, String>>> futureRemoteFolders;
  final Set<String> selectedFolders = {};

  @override
  void initState() {
    super.initState();
    final db = ref.read(databaseProvider);
    futureRemoteFolders = fetchRemoteFolders(db, widget.service.host);
  }

  void _updateSelectedFolder(String folderId, bool? add) {
    if (add == true) {
      selectedFolders.add(folderId);
    } else {
      selectedFolders.remove(folderId);
    }
    setState(() {
      selectedFolders;
    });
  }

  void _unlinkSelectedFolders() {
    final db = ref.read(databaseProvider);
    db.managers.remoteFolders
        .filter((f) => f.id.isIn(selectedFolders))
        .delete();
    futureRemoteFolders.then(
      (folders) => {
        for (String id in selectedFolders) {folders[id]!["localPath"] = ""},
        selectedFolders.clear(),
        setState(() {
          selectedFolders;
          futureRemoteFolders;
        }),
      },
    );
  }

  void _syncAll() async {
    for (String folderId in selectedFolders) {
      final remoteFolders = await futureRemoteFolders;
      final folderPath = remoteFolders[folderId]!["localPath"];
      if (folderPath != null || folderPath != "") {
        syncRemoteFolder(widget.service.host, folderId, folderPath!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.service.name)),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: FutureBuilder(
          future: futureRemoteFolders,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  for (var id in snapshot.requireData.keys)
                    RemoteFolderWidget(
                      id: id,
                      remoteFolders: snapshot.requireData,
                      isSelected: selectedFolders.contains(id),
                      onChanged: (add) => _updateSelectedFolder(id, add),
                    ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
      persistentFooterButtons: [
        OutlinedButton.icon(
          icon: const Icon(Icons.remove),
          onPressed: selectedFolders.isEmpty ? null : _unlinkSelectedFolders,
          label: const Text("Unlink"),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.red,
            side: selectedFolders.isEmpty
                ? null
                : const BorderSide(color: Colors.red),
          ),
        ),
        FilledButton.icon(
          icon: const Icon(Icons.sync),
          onPressed: selectedFolders.isEmpty ? null : _syncAll,
          label: const Text("Sync"),
        ),
      ],
    );
  }
}
