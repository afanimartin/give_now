import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

///
class ItemModel extends Equatable {
  ///
  const ItemModel(
      {@required this.id,
      @required this.userId,
      @required this.mainImageUrl,
      this.donated = false,
      this.otherImageUrls,
      this.timestamp});

  ///
  factory ItemModel.fromSnapshot(DocumentSnapshot doc) => ItemModel(
      id: doc.id,
      userId: doc['userId'] as String,
      donated: doc['donated'] as bool,
      mainImageUrl: doc['mainImageUrl'] as String,
      timestamp: doc['timestamp'] as Timestamp,
      otherImageUrls: doc['otherImageUrls'] as List<dynamic>);

  ///
  final String id;

  ///
  final String userId;

  ///
  final bool donated;

  ///
  final String mainImageUrl;

  ///
  final Timestamp timestamp;

  ///
  final List<dynamic> otherImageUrls;

  ///
  Map<String, dynamic> toDocument() => <String, dynamic>{
        'id': id,
        'userId': userId,
        'donated': donated,
        'mainImageUrl': mainImageUrl,
        'timestamp': timestamp,
        'otherImageUrls': otherImageUrls,
      };

  ///
  ItemModel copyWith(
          {String id,
          String userId,
          bool donated,
          String mainImageUrl,
          Timestamp timestamp,
          List<dynamic> otherImageUrls}) =>
      ItemModel(
          id: id ?? this.id,
          userId: userId ?? this.userId,
          donated: donated ?? this.donated,
          mainImageUrl: mainImageUrl ?? this.mainImageUrl,
          timestamp: timestamp ?? this.timestamp,
          otherImageUrls: otherImageUrls ?? this.otherImageUrls);

  @override
  List<Object> get props =>
      [id, userId, donated, mainImageUrl, timestamp, otherImageUrls];
}
