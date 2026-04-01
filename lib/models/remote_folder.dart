enum RemoteFolderStatus {
  start(""),
  enqueued("Enqueued"),
  downloading("Downloading"),
  extracting("Extracting"),
  synced("Synced"),
  failed("Failed");

  final String label;

  const RemoteFolderStatus(this.label);

  bool get editable => this == start || this == synced || this == failed;
}

class RemoteFolder {
  String id;
  String name;
  String path;
  RemoteFolderStatus status;
  double downloadProgress;

  RemoteFolder({
    required this.id,
    required this.name,
    this.path = "",
    this.status = RemoteFolderStatus.start,
    this.downloadProgress = 0,
  });
}
