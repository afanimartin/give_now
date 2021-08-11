import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moostamil/models/item/item.dart';

import '../repository/item_repository_mock.dart';
import 'item_state_mock.dart';

class ItemCubit extends Cubit<ItemStateMock> {
  ItemCubit({required this.itemRepository}) : super(ItemInitialState());

  ItemRepositoryMock itemRepository;

  void addItem(Item item) async {
    try {
      await itemRepository.add(item);
    } on Exception catch (_) {}
  }

  List<Item>? getAllUploads() => itemRepository.items();
}
