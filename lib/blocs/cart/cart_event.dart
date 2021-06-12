import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/item/item.dart';

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
  final List<Item> cartItems;

  @override
  List<Object> get props => [cartItems];
}

///
class RemoveItemFromCart extends CartEvent {
  ///
  const RemoveItemFromCart({@required this.item});

  ///
  final Item item;

  ///
  @override
  List<Object> get props => [item];
}
