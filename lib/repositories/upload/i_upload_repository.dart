import '../../models/item/item.dart';

///
abstract class IUploadRepository {
  ///
  Future<void> upload(Item upload);

  ///
  Future<void> update(Item item);

  ///
  Future<void> delete(Item item);

  ///
  Stream<List<Item>> uploads();
}
