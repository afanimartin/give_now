import '../../models/item/item.dart';

import '../../models/item/sale.dart';

///
abstract class ICartRepostiory {
  ///
  Future<void> add(Item item);

  ///
  Future<void> delete(Item item);

  ///
  Future<void> checkout(Sale sale);

  ///
  Stream<List<Item>> cart();
}
