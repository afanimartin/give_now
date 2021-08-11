import '../../models/item/item.dart';

///
abstract class IItemRepository {
  ///
  Future<void> add(Item upload);

  ///
  Future<void> update(Item item);

  ///
  Future<void> delete(Item item);

  ///
  Stream<List<Item>>? allItems();
}
