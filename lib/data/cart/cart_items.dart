import '../../models/cart/cart.dart';
import '../items/items.dart';

///
double total = 0;

///
final List<Cart> itemsAddedToCart = [
  Cart(cartId: '1', cartItems: itemsForSale, total: itemsTotal),
];

///
double get itemsTotal {
  itemsForSale.forEach((item) => total += item.price);
  return total;
}
