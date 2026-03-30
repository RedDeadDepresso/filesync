import 'dart:async';
import 'dart:core';

import 'package:drift/drift.dart';
import 'package:file_picker/file_picker.dart';
import 'package:filesync/models/client.dart';
import 'package:filesync/providers/database_provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:filesync/models/remote_folder.dart';

class RemoteFoldersNotifier extends AsyncNotifier<Map<String, RemoteFolder>> {
  final String host;

  RemoteFoldersNotifier(this.host);

  @override
  FutureOr<Map<String, RemoteFolder>> build() async {
    final db = ref.read(databaseProvider);
    final remoteFolders = await fetchRemoteFolders(db, host);
    return remoteFolders;
  }

  RemoteFolder? getRemoteFolder(String folderId) {
    final remoteFolders = state.value;
    if (remoteFolders != null) return remoteFolders[folderId];
    return null;
  }

  Future<void> link(String folderId) async {
    final db = ref.read(databaseProvider);
    final remoteFolder = getRemoteFolder(folderId);
    if (remoteFolder == null) return;
    try {
      final String? pickedDirectoryPath = await FilePicker.platform
          .getDirectoryPath(dialogTitle: "Set local path");
      print(pickedDirectoryPath);
      if (pickedDirectoryPath == null) return;

      if (remoteFolder.path.isEmpty) {
        await db.managers.syncedFolders.create(
          (f) => f(id: remoteFolder.id, path: pickedDirectoryPath),
        );
      } else {
        await db.managers.syncedFolders
            .filter((f) => f.id.equals(remoteFolder.id))
            .update((f) => f(path: Value(pickedDirectoryPath)));
      }
      remoteFolder.path = pickedDirectoryPath;
      _updateState();
    } on PlatformException catch (e) {
      print('Unsupported operation: $e');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> unlink(String folderId) async {
    final db = ref.read(databaseProvider);
    await db.managers.syncedFolders
        .filter((f) => f.id.equals(folderId))
        .delete();
    _setRemoteFolderPath(folderId, "");
    _updateState();
  }

  Future<void> unlinkMulti(Iterable<String> folderIds) async {
    final db = ref.read(databaseProvider);
    await db.managers.syncedFolders
        .filter((f) => f.id.isIn(folderIds))
        .delete();
    for (String folderId in folderIds) {
      _setRemoteFolderPath(folderId, "");
    }
    _updateState();
  }

  Future<void> _sync(String folderId) async {
    final remoteFolder = getRemoteFolder(folderId);
    if (remoteFolder != null && remoteFolder.path.isNotEmpty) {
      await syncRemoteFolder(
        host,
        remoteFolder,
        onDownloadProgress: (double progress) =>
            (_onDownloadProgress(folderId, progress)),
        onExtractionStarted: () => (_onExtractionStarted(folderId)),
        onExtractionFinished: () => (_onExtractionFinished(folderId)),
      );
    }
  }

  Future<void> sync(String folderId) async {
    final folder = getRemoteFolder(folderId);
    if (folder == null) return;
    folder.isDownloading = true;
    _updateState();
    await _sync(folderId);
  }

  Future<void> syncMulti(Iterable<String> folderIds) async {
    for (String folderId in folderIds) {
      final folder = getRemoteFolder(folderId);
      if (folder != null) folder.isDownloading = true;
    }
    _updateState();
    for (String folderId in folderIds) {
      await _sync(folderId);
    }
  }

  void _onDownloadProgress(String folderId, double progress) {
    print(progress);
    final folder = getRemoteFolder(folderId);
    if (folder == null) return;
    if (progress == 1.0) {
      folder.isDownloading = false;
    } else {
      folder.isDownloading = true;
      folder.downloadProgress = progress;
    }
    _updateState();
  }

  void _onExtractionStarted(String folderId) {
    print("extraction started");
    final folder = getRemoteFolder(folderId);
    if (folder == null) return;
    folder.isDownloading = false;
    folder.isExtracting = true;
    _updateState();
  }

  void _onExtractionFinished(String folderId) {
    print("extraction finished");

    final folder = getRemoteFolder(folderId);
    if (folder == null) return;
    folder.isExtracting = false;
    _updateState();
  }

  void _setRemoteFolderPath(String folderId, String newPath) {
    final folder = getRemoteFolder(folderId);
    if (folder != null) folder.path = newPath;
  }

  void _updateState() {
    state = AsyncData(Map.from(state.value!));
  }
}

final remoteFoldersProvider =
    AsyncNotifierProvider.family<
      RemoteFoldersNotifier,
      Map<String, RemoteFolder>,
      String
    >(RemoteFoldersNotifier.new);
