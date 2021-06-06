import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/image/item_model.dart';

///
class ItemState extends Equatable {
  ///
  const ItemState();

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
  final List<ItemModel> items;
  final FirebaseAuth _firebaseAuth;

  ///
  List<ItemModel> get currentUserItems => items
      .where((item) =>
          item.userId == _firebaseAuth.currentUser.uid && !item.donated)
      .toList();

  @override
  List<Object> get props => [items];
}

///
class ItemIsBeingAdded extends ItemState {}

///
class ItemIsBeingDonated extends ItemState {}

///
class ItemIsDonatedSuccessfully extends ItemState {}
