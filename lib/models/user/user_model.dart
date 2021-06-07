import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../item/item_model.dart';

///
class UserModel extends Equatable {
  ///
  const UserModel(
      {@required this.userId,
      @required this.email,
      this.displayName,
      this.photoUrl,
      this.itemsInCart,
      this.itemsPurchased});

  ///
  factory UserModel.fromSnapshot(DocumentSnapshot doc) => UserModel(
      userId: doc.id,
      email: doc['email'] as String,
      displayName: doc['display_name'] as String,
      photoUrl: doc['photo_url'] as String,
      itemsInCart: doc['items_in_cart'] as List<ItemModel>,
      itemsPurchased: doc['items_purchased'] as List<ItemModel>);

  ///
  static const empty =
      UserModel(userId: '', email: '', displayName: '', photoUrl: '');

  ///
  final String userId;

  ///
  final String email;

  ///
  final String displayName;

  ///
  final String photoUrl;

  ///
  final List<ItemModel> itemsInCart;

  ///
  final List<ItemModel> itemsPurchased;

  ///
  Map<String, dynamic> toDocument() => <String, dynamic>{
        'userId': userId,
        'email': email,
        'display_name': displayName,
        'photo_url': photoUrl,
        'items_in_cart': itemsInCart,
        'items_purchased': itemsPurchased
      };

  @override
  List<Object> get props =>
      [userId, email, displayName, photoUrl, itemsInCart, itemsPurchased];
}
