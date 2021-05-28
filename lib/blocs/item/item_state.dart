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
  ItemUpdated({@required this.images, FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  ///
  final List<ItemModel> images;
  final FirebaseAuth _firebaseAuth;

  ///
  List<ItemModel> get currentUserImages => images
      .where((image) => image.userId == _firebaseAuth.currentUser.uid)
      .toList();

  @override
  List<Object> get props => [images];
}

///
class ImageIsAdding extends ItemState {}
