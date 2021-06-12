import 'package:equatable/equatable.dart';

import '../../models/item/item.dart';

///
class CartState extends Equatable {
  ///
  const CartState({this.cartItems});

  ///
  final List<Item> cartItems;

    ///
  CartState copyWith({List<Item> cartItems}) =>
      CartState(cartItems: cartItems ?? this.cartItems);

  ///
  double get totalCost {
    double total = 0;

    for (int i = 0; i < cartItems.length; i++) {
      total += cartItems[i].price;
    }
    return total;
  }

  ///
  @override
  List<Object> get props => [cartItems];
}

///
// class CartUpdated extends CartState {
//   ///
//   const CartUpdated();

//   ///
//   CartState copyWith({List<Item> cartItems}) =>
//       CartState(cartItems: cartItems ?? this.cartItems);

//   ///
//   double get totalCost {
//     double total = 0;

//     for (int i = 0; i < cartItems.length; i++) {
//       total += cartItems[i].price;
//     }
//     return total;
//   }

//   @override
//   List<Object> get props => [cartItems];
// }
