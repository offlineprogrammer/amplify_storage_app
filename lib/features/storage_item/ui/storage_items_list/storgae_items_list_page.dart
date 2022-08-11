import 'dart:io';

import 'package:amplify_storage_app/features/storage_item/controller/storage_items_controller.dart';
import 'package:amplify_storage_app/features/storage_item/services/storage_service.dart';
import 'package:amplify_storage_app/features/storage_item/ui/storage_items_list/storage_item_tile.dart';
import 'package:amplify_storage_app/features/storage_item/ui/storage_items_list/upload_progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class StorageItemsListPage extends ConsumerWidget {
  const StorageItemsListPage({
    super.key,
  });

  Future<void> uploadImage({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return;
    }

    final file = File(pickedFile.path);
    showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const UploadProgressDialog();
        });
    await ref.read(storageServiceProvider).uploadFile(file);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storageItems = ref.watch(storageItemsListFutureProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Amplify Storage'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            uploadImage(
              context: context,
              ref: ref,
            ).then((value) {
              ref.refresh(storageItemsListFutureProvider);

              Navigator.of(context, rootNavigator: true).pop();
            });
            //_fetchData(context);
          },
          child: const Icon(Icons.add),
        ),
        body: storageItems.when(
            data: (items) => items!.isEmpty
                ? const Center(
                    child: Text('No Items'),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          key: const Key('StorageItemsGridView'),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 5,
                          ),
                          itemCount: items.length,
                          itemBuilder: (context, index) => StorageItemTile(
                            storageFile: items[index],
                          ),
                        ),
                      ),
                    ],
                  ),
            error: (e, st) => const Center(
                  child: Text('Error'),
                ),
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                )));
  }
}