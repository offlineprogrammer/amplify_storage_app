import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class StorageItemTile extends StatelessWidget {
  const StorageItemTile({
    required this.storageItem,
    super.key,
  });

  final Map<String, String> storageItem;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4.0,
        child: Column(children: [
          Expanded(
            child: CachedNetworkImage(
              cacheKey: storageItem['key']!,
              imageUrl: storageItem['url']!,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ]));
  }
}
