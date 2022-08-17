import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_storage_app/features/storage_file/ui/storage_files_list/storage_files_list_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    required this.isAmplifySuccessfullyConfigured,
    Key? key,
  }) : super(key: key);

  final bool isAmplifySuccessfullyConfigured;

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: MaterialApp(
        builder: Authenticator.builder(),
        home: isAmplifySuccessfullyConfigured
            ? const StorageFilesListPage()
            : const Scaffold(
                body: Center(
                  child: Text(
                    'Tried to reconfigure Amplify; '
                    'this can occur when your app restarts on Android.',
                  ),
                ),
              ),
      ),
    );
  }
}
