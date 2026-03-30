class RemoteFolder {
  String id;
  String name;
  String path;
  bool isDownloading;
  double downloadProgress;
  bool isExtracting;

  RemoteFolder({
    required this.id,
    required this.name,
    this.path = "",
    this.isDownloading = false,
    this.downloadProgress = 0,
    this.isExtracting = false,
  });
}
