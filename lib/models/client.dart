import 'package:archive/archive_io.dart';
import 'package:background_downloader/background_downloader.dart';
import 'package:filesync/models/app_service.dart';
import 'package:filesync/models/database.dart';
import 'package:dio/dio.dart';
import 'package:filesync/utils/normalize_path.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';

Future<Map<String, Map<String, String>>> fetchRemoteFolders(
  AppDatabase db,
  String? host,
) async {
  if (host == null) {
    throw Exception("Failed to resolve details about the nearby device");
  }

  final dio = Dio();
  final response = await dio.get(
    "http://$host:${DefaultAppService.port}/broadcasting-folders",
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

Future<bool> extractZipFile(String zipPath, String destinationDirPath) async {
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

    return true;
  } catch (e) {
    print('Error extracting ZIP: $e');
    return false;
  }
}

Future<bool> syncRemoteFolder(
  String? host,
  String folderId,
  String folderPath,
) async {
  if (host == null) {
    return false;
  }

  final existingFiles = await getFiles(folderPath);
  print(existingFiles);
  final filename = "$folderId.zip";
  print(folderId);
  final hasPermission = await requestStoragePermission();
  if (!hasPermission) return false;

  final task = DownloadTask(
    url:
        "http://$host:${DefaultAppService.port}/broadcasting-folders/$folderId/sync",
    post: existingFiles,
    filename: filename,
  );

  final result = await FileDownloader().download(
    task,
    onProgress: (percentage) => print(percentage),
  );
  print(result.status);
  if (result.status == TaskStatus.complete) {
    final zipPath = await task.filePath();
    print(zipPath);
    final hasPermission = await requestStoragePermission();
    if (!hasPermission) return false;
    final r = await extractZipFile(zipPath, folderPath);
    print(r);
    return r;
  }
  return false;
}
