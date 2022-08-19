import 'dart:io';

import 'package:amplify_storage_app/features/storage_file/models/storage_file.dart';
import 'package:amplify_storage_app/features/storage_file/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storageFilesControllerProvider = Provider<StorageFilesController>((ref) {
  return StorageFilesController(ref: ref);
});

final storageFilesListFutureProvider = FutureProvider<List<StorageFile>>((ref) {
  final storageFilesController = ref.watch(storageFilesControllerProvider);
  return storageFilesController.getStorageFiles();
});

class StorageFilesController {
  StorageFilesController({
    required Ref ref,
  }) : service = ref.read(storageServiceProvider);

  final StorageService service;

  Future<void> uploadFile(File file) async {
    final fileKey = await service.uploadFile(file);
    if (fileKey != null) {
      service.resetUploadProgress();
    }
  }

  Future<void> deleteFile(String fileKey) => service.deleteFile(fileKey);

  ValueNotifier<int> uploadProgress() => service.getUploadProgress();

  Future<List<StorageFile>> getStorageFiles() => service.getStorageFiles();
}
