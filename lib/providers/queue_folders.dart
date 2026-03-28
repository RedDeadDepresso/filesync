import 'package:flutter_riverpod/flutter_riverpod.dart';

final queueFoldersProvider = Provider<Map<String, Set<String>>>((ref) {
  final Map<String, Set<String>> queueFolders = {};
  return queueFolders;
});
