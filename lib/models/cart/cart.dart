import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

///
class CartItem extends Equatable {
  ///
  const CartItem(
      {@required this.id,
      @required this.sellerId,
      @required this.title,
      @required this.mainImageUrl,
      @required this.price,
      this.buyerId,
      this.createdAt});

  ///
  factory CartItem.fromSnapshot(DocumentSnapshot doc) => CartItem(
      id: doc.id,
      buyerId: doc['buyer_id'] as String,
      sellerId: doc['seller_id'] as String,
      title: doc['title'] as String,
      mainImageUrl: doc['main_image_url'] as String,
      price: doc['price'] as String,
      createdAt: doc['created_at'] as Timestamp);

  ///
  final String id;

  ///
  final String buyerId;

  ///
  final String sellerId;

  ///
  final String title;

  ///
  final String mainImageUrl;

  ///
  final String price;

  ///
  final Timestamp createdAt;

  ///
  Map<String, dynamic> toDocument() => <String, dynamic>{
        'id': id,
        'buyer_id': buyerId,
        'seller_id': sellerId,
        'title': title,
        'main_image_url': mainImageUrl,
        'price': price,
        'created_at': createdAt
      };

  @override
  List<Object> get props =>
      [id, buyerId, sellerId, title, mainImageUrl, price, createdAt];
}
