import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../../models/item/item.dart';

///
class CartState extends Equatable {
  ///
  const CartState();

  ///
  @override
  List<Object> get props => [];
}

///
class LoadingCartItems extends CartState {}

///
class CartItemsLoaded extends CartState {
  ///
  CartItemsLoaded({@required this.items, FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  ///
  final List<Item> items;

  ///
  final FirebaseAuth _firebaseAuth;

  ///
  List<Item> get currentUserCartItems => items
      .where((item) => item.buyerId == _firebaseAuth.currentUser.uid)
      .toList();

  ///
  int get totalCost {
    var _total = 0;

    for (var i = 0; i < currentUserCartItems.length; i++) {
      final _price = int.tryParse(currentUserCartItems[i].price) ?? 0;

      _total += _price;
    }
    return _total;
  }

  ///
  @override
  List<Object> get props => [items];
}

///
class AddingItemToCart extends CartState {}

///
class ItemBeingRemovedFromCart extends CartState {}

///
class ItemSuccessfullyAddedToCart extends CartState {}
