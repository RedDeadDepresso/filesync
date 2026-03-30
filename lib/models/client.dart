import 'dart:convert';
import 'package:filesync/models/remote_folder.dart';
import 'package:http/http.dart' as http;
import 'package:archive/archive_io.dart';
import 'package:background_downloader/background_downloader.dart';
import 'package:filesync/models/app_service.dart';
import 'package:filesync/utils/normalize_path.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';

Future<Map<String, RemoteFolder>> fetchRemoteFolders(String? host) async {
  if (host == null) {
    throw Exception("Failed to resolve details about the nearby device");
  }

  final response = await http.get(
    Uri.parse("http://$host:${DefaultAppService.port}/shared-folders"),
    headers: {'Accept': 'application/json'},
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to fetch remote folders');
  }

  final rawData = jsonDecode(response.body) as Map<String, dynamic>;

  final data = {
    for (var e in rawData.entries)
      e.key: RemoteFolder(id: e.key, name: e.value as String),
  };

  return data;
}

Future<Map<String, Null>> getFiles(String dirPath) async {
  Directory dir = Directory(dirPath);
  if (!await dir.exists()) return {};

  final String base = dir.path;
  final Map<String, Null> files = {};
  await dir.list(recursive: true, followLinks: false).forEach((entity) {
    if (entity is File) {
      final relativePath = normalizePath(p.relative(entity.path, from: base));
      files[relativePath] = null;
    }
  });
  return files;
}

Future<bool> requestStoragePermission() async {
  // Request storage permission
  var status = await Permission.manageExternalStorage.request();

  if (status.isGranted) {
    print('Storage permission granted');
    return true;
  } else if (status.isPermanentlyDenied) {
    print('Storage permission permanently denied. Open app settings.');
    openAppSettings(); // optional: guide user to enable manually
  } else {
    print('Storage permission denied');
  }
  return false;
}

Future<bool> extractZipFile(
  String zipPath,
  String destinationDirPath, {
  bool deleteOnSuccess = true,
}) async {
  final zipFile = File(zipPath);
  if (!await zipFile.exists()) return false;

  final destinationDir = Directory(destinationDirPath);
  if (!await destinationDir.exists()) {
    await destinationDir.create(recursive: true);
  }

  try {
    // Read the zip file as bytes
    final bytes = await zipFile.readAsBytes();

    // Decode the archive from bytes
    final archive = ZipDecoder().decodeBytes(bytes);

    for (final file in archive) {
      final filename = normalizePath(file.name);
      final outPath = p.join(destinationDir.path, filename);

      if (file.isFile) {
        final outFile = File(outPath);
        await outFile.create(recursive: true);
        await outFile.writeAsBytes(file.content as List<int>);
      } else {
        await Directory(outPath).create(recursive: true);
      }
    }

    if (deleteOnSuccess) await zipFile.delete();

    return true;
  } catch (e) {
    print('Error extracting ZIP: $e');
    return false;
  }
}

Future<bool> syncRemoteFolder(
  String? host,
  RemoteFolder remoteFolder, {
  void Function(double)? onDownloadProgress,
  void Function()? onExtractionStarted,
  void Function()? onExtractionFinished,
}) async {
  if (host == null) {
    return false;
  }
  final excludeFiles = await getFiles(remoteFolder.path);
  print(excludeFiles);
  final filename = "${remoteFolder.id}.zip";
  print(remoteFolder.id);
  final hasPermission = await requestStoragePermission();
  if (!hasPermission) return false;

  final task = DownloadTask(
    url:
        "http://$host:${DefaultAppService.port}/shared-folders/${remoteFolder.id}/sync",

    post: excludeFiles,
    filename: filename,
    baseDirectory: BaseDirectory.temporary,
  );
  final result = await FileDownloader().download(
    task,
    onProgress: onDownloadProgress,
  );
  print(result.status);
  if (result.status == TaskStatus.complete) {
    if (onExtractionStarted != null) onExtractionStarted();
    final zipPath = await task.filePath();
    print(zipPath);
    final hasPermission = await requestStoragePermission();
    if (!hasPermission) return false;
    final bool extracted = await extractZipFile(zipPath, remoteFolder.path);
    if (onExtractionFinished != null) onExtractionFinished();
    return extracted;
  }
  return false;
}
