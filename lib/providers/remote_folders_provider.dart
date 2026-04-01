import 'dart:async';
import 'dart:core';

import 'package:background_downloader/background_downloader.dart';
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
    FileDownloader().registerCallbacks(
      group: host,
      taskProgressCallback: _handleDownloadProgress,
      taskStatusCallback: _handleDownloadStatus,
    );
    final db = ref.read(databaseProvider);
    final remoteFolders = await fetchRemoteFolders(host);
    final syncedFolders = await db.managers.syncedFolders
        .filter((f) => f.id.isIn(remoteFolders.keys))
        .get();

    for (var syncedFolder in syncedFolders) {
      final remoteFolder = remoteFolders[syncedFolder.id];
      if (remoteFolder != null) {
        remoteFolder.path = syncedFolder.path;
      }
    }
    return remoteFolders;
  }

  Future<void> refresh() async {
    final remoteFolders = await fetchRemoteFolders(host);

    for (RemoteFolder oldFolder in state.value!.values) {
      final remoteFolder = remoteFolders[oldFolder.id];
      if (remoteFolder != null) {
        remoteFolder.status = oldFolder.status;
        remoteFolder.downloadProgress = oldFolder.downloadProgress;
        remoteFolder.path = oldFolder.path;
      }
    }

    state = AsyncData(remoteFolders);
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
      final enqueued = await syncRemoteFolder(host, remoteFolder);
      if (!enqueued) {
        remoteFolder.status = RemoteFolderStatus.failed;
        _updateState();
      }
    }
  }

  Future<void> sync(String folderId) async {
    final folder = getRemoteFolder(folderId);
    if (folder == null) return;
    folder.status = RemoteFolderStatus.enqueued;
    _updateState();
    await _sync(folderId);
  }

  Future<void> syncMulti(Iterable<String> folderIds) async {
    for (String folderId in folderIds) {
      final folder = getRemoteFolder(folderId);
      if (folder != null) folder.status = RemoteFolderStatus.enqueued;
    }
    _updateState();
    for (String folderId in folderIds) {
      await _sync(folderId);
    }
  }

  void _handleDownloadProgress(TaskProgressUpdate update) {
    print("Progress: ${update.progress}");
    final folder = getRemoteFolder(update.task.metaData);
    if (folder == null) return;
    folder.status = RemoteFolderStatus.downloading;
    folder.downloadProgress = update.progress;
    _updateState();
  }

  void _handleDownloadStatus(TaskStatusUpdate update) {
    final folder = getRemoteFolder(update.task.metaData);
    if (folder == null) return;
    if (update.status == TaskStatus.complete) {
      folder.status = RemoteFolderStatus.extracting;
      _updateState();
      _extract(folder, update.task);
    } else if (update.status == TaskStatus.canceled ||
        update.status == TaskStatus.failed ||
        update.status == TaskStatus.notFound) {
      folder.status = RemoteFolderStatus.failed;
      _updateState();
    }
  }

  Future<bool> _extract(RemoteFolder folder, Task task) async {
    bool success = false;
    final hasPermission = await requestPermissions();
    if (hasPermission) {
      final zipPath = await task.filePath();
      success = await extractZipFile(zipPath, folder.path);
    }
    if (success) {
      folder.status = RemoteFolderStatus.synced;
    } else {
      folder.status = RemoteFolderStatus.failed;
    }
    _updateState();
    return success;
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
