import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import '../main.dart';
import 'dart:io';

class StorageService {
  ValueNotifier<double> uploadProgress = ValueNotifier<double>(0);

  Future<List<Map<String, String>>?> getStorageItems() async {
    List<Map<String, String>> files = [];

    try {
      final ListResult result = await Amplify.Storage.list();
      final List<StorageItem> storageItems = result.items.reversed.toList();
      await Future.forEach<StorageItem>(storageItems, (file) async {
        final String fileUrl = await getImageUrl(file.key);

        files.add({
          "key": file.key,
          "url": fileUrl,
        });
      });
      return files;
    } on Exception catch (e) {
      _showError(e);
    }
    return null;
  }

  Future<String> getImageUrl(String key) async {
    final GetUrlResult result = await Amplify.Storage.getUrl(
      key: key,
      options: S3GetUrlOptions(expires: 60000),
    );
    return result.url;
  }

  Future<void> uploadFile(File file) async {
    try {
      await Amplify.Storage.uploadFile(
          local: file,
          key: DateTime.now().toString(),
          onProgress: (progress) {
            uploadProgress.value = progress.getFractionCompleted();
          });
    } on Exception catch (e) {
      _showError(e);
    }
  }

  void _showError(Exception e) {
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(e.toString()),
    ));
  }
}
