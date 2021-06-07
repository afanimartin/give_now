import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import '../../data/items/items.dart';
import '../../models/item/item.dart';

///
class CartState extends Equatable {
  ///
  CartState();

  ///
  List<Item> get currentUserCartItems => itemsForSale;

  ///
  double total = 0;

  ///
  double get totalCost {
    itemsForSale.forEach((item) {
      total += item.price;
    });

    return total;
  }

  @override
  List<Object> get props => [];
}

///
class CartUpdated extends CartState {
  ///
  CartUpdated({@required this.cartItems});

  ///
  final List<Item> cartItems;

  @override
  List<Object> get props => [cartItems];
}
