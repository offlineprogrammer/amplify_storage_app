import 'package:amplify_storage_app/features/storage_file/controller/storage_files_controller.dart';
import 'package:amplify_storage_app/features/storage_file/models/storage_file.dart';
import 'package:amplify_storage_app/features/storage_file/ui/storage_files_list/storage_files_list_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders Error on error', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          storageFilesListFutureProvider.overrideWithValue(
            const AsyncValue.error('Error'),
          ),
        ],
        child: const MaterialApp(
          home: StorageFilesListPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Error'), findsOneWidget);
  });

  testWidgets('renders No Items on empty list', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          storageFilesListFutureProvider.overrideWithValue(
            const AsyncValue.data([]),
          ),
        ],
        child: const MaterialApp(
          home: StorageFilesListPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('No Items'), findsOneWidget);
  });

  testWidgets('renders images on data', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          storageFilesListFutureProvider.overrideWithValue(
            const AsyncValue.data([StorageFile(key: 'key1', url: 'url1')]),
          ),
        ],
        child: const MaterialApp(
          home: StorageFilesListPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final key = find.byKey(const Key('StorageItemsGridView'));

    expect(key, findsOneWidget);
  });
}
