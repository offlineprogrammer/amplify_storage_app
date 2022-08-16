import 'package:amplify_storage_app/features/storage_file/models/storage_file.dart';
import 'package:amplify_storage_app/utils.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/foundation.dart' show ValueNotifier;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as p;

final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService();
});

class StorageService {
  ValueNotifier<double> uploadProgress = ValueNotifier<double>(0);

  Future<List<StorageFile>> getStorageFiles() async {
    List<StorageFile> storageItemsList = [];

    try {
      final ListResult result = await Amplify.Storage.list();
      final List<StorageItem> storageItems = result.items;

      if (storageItems.isNotEmpty) {
        storageItems.sort((a, b) => b.lastModified!.compareTo(a.lastModified!));

        await Future.forEach<StorageItem>(storageItems, (file) async {
          final String fileUrl = await getImageUrl(file.key);

          storageItemsList.add(StorageFile(key: file.key, url: fileUrl));
        });
      }
    } on Exception catch (e) {
      logger.e(e);
    }
    return storageItemsList;
  }

  Future<String> getImageUrl(String key) async {
    final GetUrlResult result = await Amplify.Storage.getUrl(
      key: key,
      options: S3GetUrlOptions(expires: 60000),
    );
    return result.url;
  }

  ValueNotifier<double> getUploadProgress() => uploadProgress;

  Future<String?> uploadFile(File file) async {
    try {
      final extension = p.extension(file.path);
      final key = const Uuid().v1() + extension;
      await Amplify.Storage.uploadFile(
        local: file,
        key: key,
        onProgress: (progress) {
          uploadProgress.value = progress.getFractionCompleted() * 100;
        },
      );

      return key;
    } on Exception catch (e) {
      logger.e(e);
      return null;
    }
  }

  void resetUploadProgress() {
    uploadProgress.value = 0;
  }
}
