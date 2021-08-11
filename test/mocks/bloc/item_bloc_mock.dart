import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/item_repository_mock.dart';
import 'item_state_mock.dart';

class ItemCubit extends Cubit<ItemStateMock> {
  ItemCubit({required this.itemRepository})
      : super(ItemInitialState());

  ItemRepositoryMock itemRepository;

  void getAllUploads() async {
    try {
      final items = await itemRepository.uploads();
      emit(ItemsLoaded(items: items));
    } on Exception catch (_) {}
  }
}
