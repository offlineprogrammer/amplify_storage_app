import 'package:cached_network_image/cached_network_image.dart';
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
            child: CachedNetworkImage(
              imageUrl: storageItem['url']!,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
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
