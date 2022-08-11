import 'package:amplify_storage_app/features/storage_item/models/storage_file.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class StorageItemTile extends StatelessWidget {
  const StorageItemTile({
    required this.storageFile,
    super.key,
  });

  final StorageFile storageFile;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4.0,
        child: Column(children: [
          Expanded(
            child: CachedNetworkImage(
              cacheKey: storageFile.key,
              imageUrl: storageFile.url,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ]));
  }
}
