import 'package:flutter_test/flutter_test.dart';

import '../mocks/bloc/item_cubit_mock.dart';
import '../mocks/data/mocked_item.dart';
import '../mocks/repository/item_repository_mock.dart';

void main() {
  final itemCubit = ItemCubitMock(itemRepository: ItemRepositoryMock());

  setUp(() {});

  tearDown(() {
    itemCubit.clearCollection();
    // ignore: cascade_invocations
    itemCubit.close();
  });

  group('ItemCubit', () {
    test('empty items list:itemCubit.fetchAllItems().length==0', () {
      expect(itemCubit.fetchAllItems()!.length, 0);
    });
    test('add item, fetch all items:itemCubit.fetchAllItems().length==1',
        () async {
      itemCubit.addItem(itemOne);

      final items = itemCubit.fetchAllItems();

      expect(items?.length, 1);
    });

    test(
        // ignore: lines_longer_than_80_chars
        'add item:itemCubit.fetchAllItems().length==1, delete item:itemCubit.fetchAllItems().length==0',
        () {
      itemCubit.addItem(itemOne);

      final items = itemCubit.fetchAllItems();

      expect(items?.length, 1);

      itemCubit.deleteItem(itemOne);
      expect(items?.length, 0);
    });

    test('add item:itemCubit.fetchAllItems().length==1, update item', () {
      itemCubit.addItem(itemOne);

      final items = itemCubit.fetchAllItems();

      expect(items?.length, 1);

      final updatedItem = items?[0].copyWith(title: 'updated title');
      itemCubit.updateItem(updatedItem);

      expect(items?[0].title, 'updated title');
    });
  });
}
