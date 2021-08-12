import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moostamil/models/item/item.dart';

import '../repository/item_repository_mock.dart';
import 'item_state_mock.dart';

class ItemCubitMock extends Cubit<ItemStateMock> {
  ItemCubitMock({required this.itemRepository}) : super(ItemInitialState());

  ItemRepositoryMock itemRepository;

  void addItem(Item item) async {
    try {
      await itemRepository.add(item);
    } on Exception catch (_) {}
  }

  List<Item>? fetchAllItems() => itemRepository.items();

  void updateItem(Item? item) async {
    try {
      await itemRepository.update(item);
    } on Exception catch (_) {}
  }

  void deleteItem(Item item) async {
    try {
      await itemRepository.delete(item);
    } on Exception catch (_) {}
  }

  void clearCollection() {
    try {
      itemRepository.clearCollection();
    } on Exception catch (_) {}
  }
}
