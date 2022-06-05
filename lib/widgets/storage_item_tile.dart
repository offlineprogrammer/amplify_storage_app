import 'package:flutter/material.dart';

class StorageItemTile extends StatelessWidget {
  final Map<String, String> storageItem;

  const StorageItemTile(
    this.storageItem,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4.0,
        child: Column(children: [
          Expanded(
            child: Image(
              image: NetworkImage(storageItem['url']!),
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          // ButtonBar(
          //   children: [
          //     IconButton(
          //       icon: const Icon(Icons.add),
          //       onPressed: () {/* ... */},
          //     ),
          //     IconButton(
          //       icon: const Icon(Icons.info),
          //       onPressed: () {/* ... */},
          //     )
          //   ],
          // )
        ]));
  }
}
