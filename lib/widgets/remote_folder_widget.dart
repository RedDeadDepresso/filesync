import 'package:filesync/models/remote_folder.dart';
import 'package:flutter/material.dart';

/// Allows to display a discovered service.
class RemoteFolderWidget extends StatelessWidget {
  /// The discovered service.
  final RemoteFolder remoteFolder;
  final bool? isSelected;
  final Function(bool?)? onChanged;
  final Function()? onSync;
  final Function()? onLink;
  final Function()? onView;
  final Function()? onUnlink;

  /// Creates a new service widget.
  const RemoteFolderWidget({
    super.key,
    required this.remoteFolder,
    this.isSelected = false,
    this.onChanged,
    this.onSync,
    this.onView,
    this.onLink,
    this.onUnlink,
  });

  @override
  Widget build(BuildContext context) {
    if (remoteFolder.isDownloading || remoteFolder.isExtracting) {
      final String status = remoteFolder.isDownloading
          ? "Downloading"
          : "Extracting";
      return Card(
        child: ListTile(
          leading:
              remoteFolder.isDownloading &&
                  (0.0 < remoteFolder.downloadProgress &&
                      remoteFolder.downloadProgress < 1.0)
              ? CircularProgressIndicator(value: remoteFolder.downloadProgress)
              : CircularProgressIndicator(),
          title: Text("${remoteFolder.name} - $status"),
          subtitle: Text(remoteFolder.path),
        ),
      );
    }
    return Card(
      child: CheckboxListTile(
        title: Text(remoteFolder.name),
        subtitle: remoteFolder.path.isEmpty ? null : Text(remoteFolder.path),
        secondary: remoteFolder.path.isEmpty
            ? TextButton(onPressed: onLink, child: const Text("Link"))
            : PopupMenuButton(
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  PopupMenuItem(onTap: onSync, child: Text('Sync')),
                  PopupMenuItem(onTap: onView, child: Text('View')),
                  PopupMenuItem(onTap: onLink, child: Text('Link')),
                  PopupMenuItem(
                    onTap: onUnlink,
                    child: Text('Unlink', style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
        value: isSelected,
        enabled: remoteFolder.path.isNotEmpty,
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: onChanged,
      ),
    );
  }
}
