import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../category/category.dart';

///
class Item extends Equatable {
  ///
  const Item(
      {@required this.id,
      @required this.sellerId,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.category,
      @required this.mainImageUrl,
      this.isDonated = false,
      this.isSold = false,
      this.condition = 'Used',
      this.buyerId,
      this.otherImageUrls,
      this.timestamp});

  ///
  factory Item.fromSnapshot(DocumentSnapshot doc) => Item(
        id: doc.id,
        sellerId: doc['seller_id'] as String,
        buyerId: doc['buyer_id'] as String,
        isDonated: doc['is_donated'] as bool,
        isSold: doc['is_sold'] as bool,
        title: doc['title'] as String,
        description: doc['description'] as String,
        condition: doc['condition'] as String,
        price: doc['price'] as double,
        category: doc['category'] as Category,
        mainImageUrl: doc['main_image_url'] as String,
        otherImageUrls: doc['other_image_urls'] as List<dynamic>,
        timestamp: doc['timestamp'] as Timestamp,
      );

  ///
  final String id;

  ///
  final String sellerId;

  ///
  final String buyerId;

  ///
  final bool isDonated;

  ///
  final bool isSold;

  ///
  final String title;

  ///
  final String description;

  ///
  final String condition;

  ///
  final double price;

  ///
  final Category category;

  ///
  final String mainImageUrl;

  ///
  final List<dynamic> otherImageUrls;

  ///
  final Timestamp timestamp;

  ///
  Map<String, dynamic> toDocument() => <String, dynamic>{
        'id': id,
        'user_id': sellerId,
        'buyer_id': buyerId,
        'is_donated': isDonated,
        'is_sold': isSold,
        'title': title,
        'description': description,
        'condition': condition,
        'price': price,
        'category': category,
        'main_image_url': mainImageUrl,
        'timestamp': timestamp,
        'other_image_urls': otherImageUrls,
      };

  ///
  Item copyWith(
          {String id,
          String sellerId,
          String buyerId,
          bool isDonated,
          bool isSold,
          String title,
          String description,
          String condition,
          double price,
          Category category,
          String mainImageUrl,
          Timestamp timestamp,
          List<dynamic> otherImageUrls}) =>
      Item(
          id: id ?? this.id,
          sellerId: sellerId ?? this.sellerId,
          buyerId: buyerId ?? this.buyerId,
          isDonated: isDonated ?? this.isDonated,
          title: title ?? this.title,
          description: description ?? this.description,
          condition: condition ?? this.condition,
          price: price ?? this.price,
          category: category ?? this.category,
          mainImageUrl: mainImageUrl ?? this.mainImageUrl,
          timestamp: timestamp ?? this.timestamp,
          otherImageUrls: otherImageUrls ?? this.otherImageUrls);

  @override
  List<Object> get props => [
        id,
        sellerId,
        isDonated,
        title,
        description,
        condition,
        price,
        mainImageUrl,
        timestamp,
        otherImageUrls
      ];
}
