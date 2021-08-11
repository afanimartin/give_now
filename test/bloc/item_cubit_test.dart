import 'package:flutter_test/flutter_test.dart';

import '../mocks/bloc/item_bloc_mock.dart';
import '../mocks/repository/item_repository_mock.dart';

void main() {
  ItemCubit itemCubit;
  final ItemRepositoryMock itemRepository;

  setUp(() {
    itemCubit = ItemCubit(itemRepository: ItemRepositoryMock());
  });

  tearDown(() {
    // itemCubit.close();
  });
}
