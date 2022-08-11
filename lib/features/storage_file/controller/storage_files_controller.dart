import 'dart:io';

import 'package:amplify_storage_app/features/storage_file/models/storage_file.dart';
import 'package:amplify_storage_app/features/storage_file/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storageFilesControllerProvider = Provider<StorageFilesController>((ref) {
  return StorageFilesController(ref);
});

final storageFilesListFutureProvider = FutureProvider<List<StorageFile>>((ref) {
  final storageFilesController = ref.watch(storageFilesControllerProvider);
  return storageFilesController.getStorageFiles();
});

class StorageFilesController {
  final Ref ref;

  StorageFilesController(this.ref);

  Future<void> uploadFile(File file) async {
    final fileKey = await ref.read(storageServiceProvider).uploadFile(file);
    if (fileKey != null) {
      ref.read(storageServiceProvider).resetUploadProgress();
    }
  }

  ValueNotifier<double> uploadProgress() {
    return ref.read(storageServiceProvider).getUploadProgress();
  }

  Future<List<StorageFile>> getStorageFiles() async {
    List<StorageFile> storageItemsList = [];

    storageItemsList = await ref.read(storageServiceProvider).getStorageFiles();

    return storageItemsList;
  }
}
