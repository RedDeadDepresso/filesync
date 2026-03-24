import 'package:flutter_riverpod/flutter_riverpod.dart';

class BroadcastingFolder {
  final String name;
  final String path;
  BroadcastingFolder(this.name, this.path);
}

/// The broadcast service list provider.
final broadcastingFolderListProvider =
    NotifierProvider.autoDispose<
      BroadcastingFolderListNotifier,
      List<BroadcastingFolder>
    >(BroadcastingFolderListNotifier.new);

/// A model that allows to control the services to broadcast.
class BroadcastingFolderListNotifier
    extends Notifier<List<BroadcastingFolder>> {
  @override
  List<BroadcastingFolder> build() {
    return [];
  }

  /// Adds a service to the list.
  void add(BroadcastingFolder folder) {
    state = [...state, folder];
  }

  /// Removes a service from the list.
  void remove(BroadcastingFolder folder) {
    state = [
      for (BroadcastingFolder current in state)
        if (current.name != folder.name) current,
    ];
  }
}
