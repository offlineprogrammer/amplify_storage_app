import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../services/storage_service.dart';
import '../widgets/storage_item_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final StorageService _storageService = StorageService();
  List<Map<String, String>> _storageItems = const [];
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _getLatestStorageItems();
  }

  Future<void> _getLatestStorageItems() async {
    try {
      final storageItems = await _storageService.getStorageItems();
      setState(() {
        _storageItems = storageItems!;

        print(storageItems);
      });
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(e.toString()),
      ));
    }
  }

  Future<void> uploadImage(BuildContext context) async {
    // Select image from user's gallery
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      print('No image selected');
      return;
    }

    final file = File(pickedFile.path);
    showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ValueListenableBuilder(
                valueListenable: _storageService.uploadProgress,
                builder: (context, value, child) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                          '${(double.parse(value.toString()) * 100).toInt()} %'),
                      Container(
                          alignment: Alignment.topCenter,
                          margin: EdgeInsets.all(20),
                          child: LinearProgressIndicator(
                            value: double.parse(value.toString()),
                            backgroundColor: Colors.grey,
                            color: Colors.purple,
                            minHeight: 10,
                          )),
                    ],
                  );
                },
              ),
            ),
          );

          // new Row(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     new CircularProgressIndicator(),
          //     new Text("Loading"),
          //   ],
        } // ),

        );
    await _storageService.uploadFile(file);
    await _getLatestStorageItems();
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          uploadImage(context);
          //_fetchData(context);
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 5,
              ),
              itemCount: _storageItems.length,
              itemBuilder: (context, index) =>
                  StorageItemTile(_storageItems[index]),
            ),
          ),
        ],
      ),
    );
  }
}
