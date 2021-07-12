import '../../models/cart/cart.dart';
import '../../models/item/sale.dart';

///
abstract class ICartRepostiory {
  ///
  Future<void> add(CartItem cartItem);

  ///
  Future<void> delete(CartItem cartItem);

  ///
  Future<void> checkout(Sale sale);

  ///
  Stream<List<CartItem>> cart();
}
