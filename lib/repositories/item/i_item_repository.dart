import '../../models/item/item.dart';

///
abstract class IItemRepository {
  ///
  Future<void> upload(Item upload);

  ///
  Future<void> update(Item item);
}
