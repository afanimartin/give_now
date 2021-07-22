import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
  const UpdateCartItems({@required this.items});

  ///
  final List<Item> items;

  @override
  List<Object> get props => [items];
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
  final Item item;

  ///
  @override
  List<Object> get props => [item];
}
