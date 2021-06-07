import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../item/item.dart';

///
class Cart extends Equatable {
  ///
  const Cart(
      {@required this.cartId, @required this.cartItems, @required this.total});

  ///
  final String cartId;

  ///
  final List<Item> cartItems;

  ///
  final double total;

  @override
  List<Object> get props => [cartId, cartItems, total];
}
