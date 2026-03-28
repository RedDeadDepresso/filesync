import 'package:drift/drift.dart';
import 'package:file_picker/file_picker.dart';
import 'package:filesync/models/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Allows to display a discovered service.
class RemoteFolderWidget extends ConsumerStatefulWidget {
  /// The discovered service.
  final String id;
  final Map<String, Map<String, String>> remoteFolders;
  final bool? isSelected;
  final Function(bool?)? onChanged;

  /// Creates a new service widget.
  const RemoteFolderWidget({
    super.key,
    required this.id,
    required this.remoteFolders,
    this.isSelected = false,
    this.onChanged,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RemoteFolderWidgetState();
}

class _RemoteFolderWidgetState extends ConsumerState<RemoteFolderWidget> {
  String? pickedDirectoryPath;
  Map<String, String>? get data => widget.remoteFolders[widget.id];
  bool get isValid =>
      data != null &&
      data!.containsKey("name") &&
      data!.containsKey("localPath");

  String get id => widget.id;
  String get name => data!["name"] ?? "";
  
  set name(String value) {
    data!["name"] = value;
  }

  String get localPath => data!["localPath"] ?? "";
  set localPath(String value) {
    data!["localPath"] = value;
  }

  void _selectFolder() async {
    final db = ref.read(databaseProvider);
    try {
      pickedDirectoryPath = await FilePicker.platform.getDirectoryPath(
        dialogTitle: "Set local path",
      );
      if (pickedDirectoryPath == null) return;
      if (localPath.isEmpty) {
        await db.managers.remoteFolders.create(
          (f) => f(id: id, name: name, localPath: pickedDirectoryPath!),
        );
      } else {
        await db.managers.remoteFolders
            .filter((f) => f.id.equals(id))
            .update((f) => f(localPath: Value(pickedDirectoryPath!)));
      }
      localPath = pickedDirectoryPath!;
      setState(() {
        widget.remoteFolders;
      });
    } on PlatformException catch (e) {
      print('Unsupported operation: $e');
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: CheckboxListTile(
        title: Text(name),
        subtitle: Text(localPath),
        secondary: TextButton(
          onPressed: _selectFolder,
          child: const Text("Link"),
        ),
        value: widget.isSelected,
        enabled: localPath.isNotEmpty,
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: widget.onChanged,
      ),
    );
  }
}
