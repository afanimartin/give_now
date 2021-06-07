import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../data/items/items.dart';
import '../../models/item/item.dart';

///
class ItemState extends Equatable {
  ///
  const ItemState();

  ///
  List<Item> get currentUserItems => itemsForSale;

  @override
  List<Object> get props => [];
}

///
class ItemUpdated extends ItemState {
  ///
  ItemUpdated({
    @required this.items,
    FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  ///
  final List<Item> items;
  final FirebaseAuth _firebaseAuth;

  ///
  @override
  List<Item> get currentUserItems => itemsForSale;

  @override
  List<Object> get props => [items];
}

///
class ItemIsBeingAdded extends ItemState {}

///
class ItemIsBeingDonated extends ItemState {}

///
class ItemIsDonatedSuccessfully extends ItemState {}
