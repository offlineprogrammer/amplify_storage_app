import 'dart:io';

import 'package:amplify_storage_app/features/storage_item/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storageItemsControllerProvider = Provider<StorageItemsController>((ref) {
  return StorageItemsController(ref);
});

final storageItemsListFutureProvider =
    FutureProvider<List<Map<String, String>>?>((ref) {
  final storageItemsController = ref.watch(storageItemsControllerProvider);
  return storageItemsController.getStorageItems();
});

class StorageItemsController {
  final Ref ref;

  StorageItemsController(this.ref);

  Future<void> uploadFile(File file) async {
    final fileKey = await ref.read(storageServiceProvider).uploadFile(file);
    if (fileKey != null) {
      ref.read(storageServiceProvider).resetUploadProgress();
    }
  }

  ValueNotifier<double> uploadProgress() {
    return ref.read(storageServiceProvider).getUploadProgress();
  }

  Future<List<Map<String, String>>?> getStorageItems() async {
    List<Map<String, String>>? storageItemsList = [];

    storageItemsList = await ref.read(storageServiceProvider).getStorageItems();

    return storageItemsList;
  }
}
