import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as p;

class StorageService {
  ValueNotifier<double> uploadProgress = ValueNotifier<double>(0);

  Future<List<Map<String, String>>?> getStorageItems() async {
    List<Map<String, String>> storageItemsList = [];

    try {
      final ListResult result = await Amplify.Storage.list();
      final List<StorageItem> storageItems = result.items.reversed.toList();
      await Future.forEach<StorageItem>(storageItems, (file) async {
        final String fileUrl = await getImageUrl(file.key);

        storageItemsList.add({
          "key": file.key,
          "url": fileUrl,
        });
      });
      return storageItemsList;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<String> getImageUrl(String key) async {
    final GetUrlResult result = await Amplify.Storage.getUrl(
      key: key,
      options: S3GetUrlOptions(expires: 60000),
    );
    return result.url;
  }

  ValueNotifier<double> getUploadProgress() {
    return uploadProgress;
  }

  Future<String?> uploadFile(File file) async {
    try {
      final extension = p.extension(file.path);
      final key = const Uuid().v1() + extension;
      await Amplify.Storage.uploadFile(
          local: file,
          key: key,
          onProgress: (progress) {
            uploadProgress.value = progress.getFractionCompleted();
          });

      // getStorageItems();

      return key;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  void resetUploadProgress() {
    uploadProgress.value = 0;
  }
}

final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService();
});

final storageItemsListFutureProvider =
    FutureProvider<List<Map<String, String>>?>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  return storageService.getStorageItems();
});




// class StorageService {
//   ValueNotifier<double> uploadProgress = ValueNotifier<double>(0);

//   Future<List<Map<String, String>>?> getStorageItems() async {
//     List<Map<String, String>> files = [];

//     try {
//       final ListResult result = await Amplify.Storage.list();
//       final List<StorageItem> storageItems = result.items.reversed.toList();
//       await Future.forEach<StorageItem>(storageItems, (file) async {
//         final String fileUrl = await getImageUrl(file.key);

//         files.add({
//           "key": file.key,
//           "url": fileUrl,
//         });
//       });
//       return files;
//     } on Exception catch (e) {
//       _showError(e);
//     }
//     return null;
//   }

//   Future<String> getImageUrl(String key) async {
//     final GetUrlResult result = await Amplify.Storage.getUrl(
//       key: key,
//       options: S3GetUrlOptions(expires: 60000),
//     );
//     return result.url;
//   }

//   Future<void> uploadFile(File file) async {
//     try {
//       await Amplify.Storage.uploadFile(
//           local: file,
//           key: DateTime.now().toString(),
//           onProgress: (progress) {
//             uploadProgress.value = progress.getFractionCompleted();
//           });
//     } on Exception catch (e) {
//       _showError(e);
//     }
//   }

//   void _showError(Exception e) {
//     scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
//       backgroundColor: Colors.red,
//       content: Text(e.toString()),
//     ));
//   }
// }

