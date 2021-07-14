import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

///
class Item extends Equatable {
  ///
  const Item(
      {@required this.id,
      @required this.sellerId,
      @required this.sellerPhotoUrl,
      @required this.sellerPhoneNumber,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.category,
      @required this.mainImageUrl,
      this.quantity = 1,
      this.condition = 'used',
      this.buyerId,
      this.buyerPhoneNumber,
      this.otherImageUrls,
      this.createdAt,
      this.updatedAt});

  ///
  factory Item.fromSnapshot(DocumentSnapshot doc) => Item(
      id: doc.id,
      sellerId: doc['seller_id'] as String,
      sellerPhotoUrl: doc['seller_photo_url'] as String,
      sellerPhoneNumber: doc['seller_phone_number'] as String,
      buyerId: doc['buyer_id'] as String,
      buyerPhoneNumber: doc['buyer_phone_number'] as String,
      title: doc['title'] as String,
      description: doc['description'] as String,
      quantity: doc['quantity'] as int,
      condition: doc['condition'] as String,
      price: doc['price'] as String,
      category: doc['category'] as String,
      mainImageUrl: doc['main_image_url'] as String,
      otherImageUrls: doc['other_image_urls'] as List<dynamic>,
      createdAt: doc['created_at'] as Timestamp,
      updatedAt: doc['updated_at'] as Timestamp);

  ///
  final String id;

  ///
  final String sellerId;

  ///
  final String sellerPhotoUrl;

  ///
  final String sellerPhoneNumber;

  ///
  final String buyerId;

  ///
  final String buyerPhoneNumber;

  ///
  final String title;

  ///
  final String description;

  ///
  final int quantity;

  ///
  final String condition;

  ///
  final String price;

  ///
  final String category;

  ///
  final String mainImageUrl;

  ///
  final List<dynamic> otherImageUrls;

  ///
  final Timestamp createdAt;

  ///
  final Timestamp updatedAt;

  ///
  Map<String, dynamic> toDocument() => <String, dynamic>{
        'id': id,
        'seller_id': sellerId,
        'seller_photo_url': sellerPhotoUrl,
        'seller_phone_number': sellerPhoneNumber,
        'buyer_id': buyerId,
        'buyer_phone_number': buyerPhoneNumber,
        'title': title,
        'description': description,
        'quantity': quantity,
        'condition': condition,
        'price': price,
        'category': category,
        'main_image_url': mainImageUrl,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'other_image_urls': otherImageUrls,
      };

  ///
  Item copyWith(
          {String id,
          String sellerId,
          String sellerPhotoUrl,
          String sellerPhoneNumber,
          String buyerId,
          String buyerPhoneNumber,
          String title,
          String description,
          int quantity,
          String condition,
          String price,
          String category,
          String mainImageUrl,
          Timestamp createdAt,
          Timestamp updatedAt,
          List<dynamic> otherImageUrls}) =>
      Item(
          id: id ?? this.id,
          sellerId: sellerId ?? this.sellerId,
          sellerPhotoUrl: sellerPhotoUrl ?? this.sellerPhotoUrl,
          sellerPhoneNumber: sellerPhoneNumber ?? this.sellerPhoneNumber,
          buyerId: buyerId ?? this.buyerId,
          buyerPhoneNumber: buyerPhoneNumber ?? buyerPhoneNumber,
          title: title ?? this.title,
          description: description ?? this.description,
          quantity: quantity ?? this.quantity,
          condition: condition ?? this.condition,
          price: price ?? this.price,
          category: category ?? this.category,
          mainImageUrl: mainImageUrl ?? this.mainImageUrl,
          createdAt: createdAt ?? this.createdAt,
          updatedAt: updatedAt ?? this.updatedAt,
          otherImageUrls: otherImageUrls ?? this.otherImageUrls);

  @override
  List<Object> get props => [
        id,
        sellerId,
        sellerPhotoUrl,
        sellerPhoneNumber,
        buyerId,
        buyerPhoneNumber,
        title,
        description,
        quantity,
        condition,
        price,
        mainImageUrl,
        createdAt,
        updatedAt,
        otherImageUrls
      ];
}
