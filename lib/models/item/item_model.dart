import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

///
class ItemModel extends Equatable {
  ///
  const ItemModel(
      {@required this.id,
      @required this.userId,
      @required this.title,
      @required this.description,
      @required this.condition,
      @required this.price,
      @required this.mainImageUrl,
      this.isDonated = false,
      this.otherImageUrls,
      this.timestamp});

  ///
  factory ItemModel.fromSnapshot(DocumentSnapshot doc) => ItemModel(
        id: doc.id,
        userId: doc['user_id'] as String,
        isDonated: doc['is_donated'] as bool,
        title: doc['title'] as String,
        description: doc['description'] as String,
        condition: doc['condition'] as String,
        price: doc['price'] as double,
        mainImageUrl: doc['main_image_url'] as String,
        otherImageUrls: doc['other_image_urls'] as List<dynamic>,
        timestamp: doc['timestamp'] as Timestamp,
      );

  ///
  final String id;

  ///
  final String userId;

  ///
  final bool isDonated;

  ///
  final String title;

  ///
  final String description;

  ///
  final String condition;

  ///
  final double price;

  ///
  final String mainImageUrl;

  ///
  final List<dynamic> otherImageUrls;

  ///
  final Timestamp timestamp;

  ///
  Map<String, dynamic> toDocument() => <String, dynamic>{
        'id': id,
        'user_id': userId,
        'is_donated': isDonated,
        'title': title,
        'description': description,
        'condition': condition,
        'price': price,
        'main_image_url': mainImageUrl,
        'timestamp': timestamp,
        'other_image_urls': otherImageUrls,
      };

  ///
  ItemModel copyWith(
          {String id,
          String userId,
          bool isDonated,
          String title,
          String description,
          String condition,
          double price,
          String mainImageUrl,
          Timestamp timestamp,
          List<dynamic> otherImageUrls}) =>
      ItemModel(
          id: id ?? this.id,
          userId: userId ?? this.userId,
          isDonated: isDonated ?? this.isDonated,
          title: title ?? this.title,
          description: description ?? this.description,
          condition: condition ?? this.condition,
          price: price ?? this.price,
          mainImageUrl: mainImageUrl ?? this.mainImageUrl,
          timestamp: timestamp ?? this.timestamp,
          otherImageUrls: otherImageUrls ?? this.otherImageUrls);

  @override
  List<Object> get props => [
        id,
        userId,
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
