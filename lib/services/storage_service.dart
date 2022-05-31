import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import '../main.dart';
import 'dart:io';

class StorageService {
  Future<List<Map<String, String>>?> getStorageItems() async {
    List<Map<String, String>> files = [];

    try {
      final ListResult result = await Amplify.Storage.list();
      final List<StorageItem> storageItems = result.items;
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
      final UploadFileResult result = await Amplify.Storage.uploadFile(
          local: file,
          key: DateTime.now().toString(),
          onProgress: (progress) {
            print("Fraction completed: " +
                progress.getFractionCompleted().toString());
          });
      print('Successfully uploaded file: ${result.key}');
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
