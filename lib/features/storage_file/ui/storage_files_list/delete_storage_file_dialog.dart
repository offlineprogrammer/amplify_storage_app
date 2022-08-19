import 'package:flutter/material.dart';

class DeleteStorageFileDialog extends StatelessWidget {
  const DeleteStorageFileDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Please Confirm'),
      content: const Text('Delete this file?'),
      actions: [
        TextButton(
            onPressed: () async {
              Navigator.of(context).pop(true);
            },
            child: const Text('Yes')),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('No'))
      ],
    );
  }
}
