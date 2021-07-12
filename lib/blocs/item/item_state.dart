import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/item/item.dart';

///
class ItemState extends Equatable {
  ///
  const ItemState();

  ///
  @override
  List<Object> get props => [];
}


///
class ItemsLoaded extends ItemState {
  ///
  ItemsLoaded({@required this.items, FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  ///
  final List<Item> items;

  ///
  final FirebaseAuth _firebaseAuth;

  ///
  List<Item> get itemsForSale => items
      .where((item) => item.sellerId != _firebaseAuth.currentUser.uid)
      .toList();

  ///
  List<Item> get currentUserItems => items
      .where((item) =>
          item.sellerId == _firebaseAuth.currentUser.uid &&
          item.isDonated == false)
      .toList();

  @override
  List<Object> get props => [items];
}

///
class ItemBeingUpdated extends ItemState {}

///
class ItemBeingDeleted extends ItemState {}

///
class ItemBeingDonated extends ItemState {}
