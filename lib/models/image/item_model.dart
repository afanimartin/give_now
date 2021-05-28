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
      otherImageUrls: doc['otherImageUrls']);

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
  final dynamic otherImageUrls;

  ///
  Map<String, dynamic> toDocument() => <String, dynamic>{
        'id': id,
        'userId': userId,
        'donated': donated,
        'mainImageUrl': mainImageUrl,
        'timestamp': timestamp,
        'otherImageUrls': otherImageUrls,
      };

  @override
  List<Object> get props =>
      [id, userId, donated, mainImageUrl, timestamp, otherImageUrls];
}
