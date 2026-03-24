import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

/// A dialog that allows to prompt for a type to discover on the network.
class FolderPromptDialog extends StatefulWidget {
  /// Creates a new discovery prompt dialog.
  const FolderPromptDialog({super.key});

  @override
  State<StatefulWidget> createState() => _FolderPromptDialogState();

  /// Prompts for a type to discover on the network.
  static Future<(String, String)?> prompt(BuildContext context) => showDialog(
    context: context,
    builder: (context) => const FolderPromptDialog(),
  );
}

/// The dialog state.
class _FolderPromptDialogState extends State<FolderPromptDialog> {
  TextEditingController name = TextEditingController();
  TextEditingController path = TextEditingController();

  void _selectFolder() async {
    try {
      String? pickedDirectoryPath = await FilePicker.platform.getDirectoryPath(
        dialogTitle: "Add a broadcasting folder",
      );
      if (pickedDirectoryPath != null) {
        path.text = pickedDirectoryPath;
        print(path.value);
      }
      setState(() {
        path.text;
        path.value;
        path;
      });
    } on PlatformException catch (e) {
      print('Unsupported operation: $e');
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    scrollable: true,
    content: SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          TextField(
            controller: name,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          Row(
            children: [
              Flexible(
                flex: 10,
                child: TextField(
                  controller: path,
                  decoration: const InputDecoration(labelText: 'Path'),
                  enabled: false,
                  readOnly: true,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                ),
              ),
              IconButton(
                onPressed: () => _selectFolder(),
                icon: const Icon(Icons.folder),
              ),
            ],
          ),
          // Card(
          //   child: ListTile(
          //     leading: Icon(Icons.folder),
          //     title: Text(pickedDirectoryPath ?? ""),
          //     subtitle: Text(pickedDirectoryPath ?? ""),
          //     trailing: TextButton(
          //       child: const Text('Pick'),
          //       onPressed: () => _selectFolder(),
          //     ),
          //     isThreeLine: true,
          //   ),
          // ),
        ],
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text('Cancel'),
      ),
      TextButton(
        onPressed: () => Navigator.pop(context, (name.text, path.text)),
        child: Text('Ok'),
      ),
    ],
  );

  @override
  void dispose() {
    super.dispose();
    name.dispose();
    path.dispose();
  }
}
