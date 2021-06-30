import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../models/cart/cart.dart';

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
class RemoveItemFromCart extends CartEvent {
  ///
  const RemoveItemFromCart({@required this.item});

  ///
  final CartItem item;

  ///
  @override
  List<Object> get props => [item];
}
