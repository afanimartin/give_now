import 'package:moostamil/models/item/item.dart';
import 'package:moostamil/repositories/item/i_item_repository.dart';

import '../data/item.dart';

class ItemRepositoryMock extends IItemRepository {
  @override
  Future<void> add(Item upload) async {
    mockedUploads.add(upload);
  }

  @override
  Future<void> update(Item item) async {
    for (var i = 0; i < mockedUploads.length; i++) {
      if (item.id == mockedUploads[i].id) {
        mockedUploads[i] = item;
      }
    }
  }

  @override
  Future<void> delete(Item? item) async {
    mockedUploads.remove(item);
  }

  List<Item>? uploads() => mockedUploads;

  @override
  Stream<List<Item>> allItems() => mockedUploads as Stream<List<Item>>;

  void clearCollection() async {
    mockedUploads.clear();
  }
}
