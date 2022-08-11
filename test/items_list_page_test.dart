import 'package:amplify_storage_app/features/storage_item/controller/storage_items_controller.dart';
import 'package:amplify_storage_app/features/storage_item/models/storage_file.dart';

import 'package:amplify_storage_app/features/storage_item/ui/storage_items_list/storgae_items_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders Error on error', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          storageItemsListFutureProvider.overrideWithValue(
            const AsyncValue.error('Error'),
          ),
        ],
        child: const MaterialApp(
          home: StorageItemsListPage(),
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
          storageItemsListFutureProvider.overrideWithValue(
            const AsyncValue.data([]),
          ),
        ],
        child: const MaterialApp(
          home: StorageItemsListPage(),
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
          storageItemsListFutureProvider.overrideWithValue(
            const AsyncValue.data([StorageFile(key: 'key1', url: 'url1')]),
          ),
        ],
        child: const MaterialApp(
          home: StorageItemsListPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final key = find.byKey(const Key('StorageItemsGridView'));

    expect(key, findsOneWidget);
  });
}
