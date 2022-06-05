import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../services/storage_service.dart';

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

  Future<void> uploadImage() async {
    // Select image from user's gallery
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      print('No image selected');
      return;
    }

    final file = File(pickedFile.path);
    await _storageService.uploadFile(file);
    await _getLatestStorageItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: uploadImage,
        child: const Icon(Icons.add),
      ),
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Flexible(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 5,
              ),
              itemCount: _storageItems.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    elevation: 4.0,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 200.0,
                          child: Image(
                            image: NetworkImage(_storageItems[index]['url']!),
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        ButtonBar(
                          children: [
                            TextButton(
                              child: const Text('CONTACT AGENT'),
                              onPressed: () {/* ... */},
                            ),
                          ],
                        )
                      ],
                    ));
              },
            ),
          ),
        ),
      ),
    );
  }
}
