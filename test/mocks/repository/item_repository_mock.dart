import 'package:moostamil/models/item/item.dart';
import 'package:moostamil/repositories/item/i_item_repository.dart';

import '../data/item.dart';

class ItemRepositoryMock extends IItemRepository {
  @override
  Future<void> upload(Item upload) async {
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

  Future<void> delete(Item? item) async {
    mockedUploads.remove(item);
  }

  Future<List<Item>>? uploads() async => mockedUploads;

  void clearCollection() async {
    mockedUploads.clear();
  }
}
