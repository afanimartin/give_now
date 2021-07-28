import '../../models/item/item.dart';

///
abstract class ICartRepostiory {
  ///
  Future<void> add(Item item);

  ///
  Future<void> delete(Item item);

  ///
  Future<void> checkout(Item sale);

  ///
  Stream<List<Item>> cart();
}
