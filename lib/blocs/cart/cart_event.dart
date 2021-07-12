import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/cart/cart.dart';
import '../../models/item/item.dart';
import '../../models/item/sale.dart';

///
class CartEvent extends Equatable {
  ///
  const CartEvent();

  @override
  List<Object> get props => [];
}

///
class LoadCartItems extends CartEvent {}

///
class UpdateCartItems extends CartEvent {
  ///
  const UpdateCartItems({@required this.cartItems});

  ///
  final List<CartItem> cartItems;

  @override
  List<Object> get props => [cartItems];
}

///
class AddItemToCart extends CartEvent {
  ///
  const AddItemToCart({@required this.cartItem});

  ///
  final Item cartItem;

  @override
  List<Object> get props => [cartItem];
}

///
class SellItem extends CartEvent {
  ///
  const SellItem({@required this.sale});

  ///
  final Sale sale;

  ///
  @override
  List<Object> get props => [sale];
}

///
class RemoveItemFromCart extends CartEvent {
  ///
  const RemoveItemFromCart({@required this.item});

  ///
  final CartItem item;

  ///
  @override
  List<Object> get props => [item];
}
