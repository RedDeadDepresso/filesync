import 'package:bonsoir/bonsoir.dart';
import 'package:filesync/models/database.dart';
import 'package:filesync/widgets/remote_folder_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

Future<Map<String, Map<String, String>>> fetchRemoteFolders(
  AppDatabase db,
  BonsoirService service,
) async {
  final host = service.host;
  if (host == null) {
    throw Exception("Failed to resolve details about the nearby device");
  }

  final dio = Dio();
  final response = await dio.get(
    "http://$host:4000/broadcasting-folders",
    options: Options(responseType: ResponseType.json),
  );

  final Map<String, Map<String, String>> data = (response.data as Map).map(
    (key, value) =>
        MapEntry(key.toString(), Map<String, String>.from(value as Map)),
  );

  final remoteFolders = await db.managers.remoteFolders
      .filter((f) => f.id.isIn(data.keys))
      .get();

  for (var f in remoteFolders) {
    data[f.id]?["localPath"] = f.localPath;
  }

  return data;
}

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
  final Set<String> seletectedFolders = {};

  @override
  void initState() {
    super.initState();
    final db = ref.read(databaseProvider);
    futureRemoteFolders = fetchRemoteFolders(db, widget.service);
  }

  void _updateSelectedFolder(String folderId, bool? add) {
    if (add == true) {
      seletectedFolders.add(folderId);
    } else {
      seletectedFolders.remove(folderId);
    }
    setState(() {
      seletectedFolders;
    });
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
                      isSelected: seletectedFolders.contains(id),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: 'Sync',
        child: Row(children: [Icon(Icons.sync), Text("Sync")]),
      
      ),
    );
  }
}
