import 'package:flutter_test/flutter_test.dart';

import '../mocks/bloc/item_cubit_mock.dart';
import '../mocks/data/item.dart';
import '../mocks/repository/item_repository_mock.dart';

void main() {
  final itemCubit = ItemCubit(itemRepository: ItemRepositoryMock());

  setUp(() {});

  tearDown(itemCubit.close);

  group('ItemCubit', () {
    test('add item, fetch all items:length==1', () async {
      itemCubit.addItem(itemOne);
      
      final items = itemCubit.getAllUploads();

      expect(items?.length, 1);
    });
  });
}
