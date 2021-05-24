import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ImageModel extends Equatable {
  final String id;
  final String userId;
  final String mainImageUrl;
  final Timestamp timestamp;
  final List<dynamic> otherImageUrls;

  ImageModel(
      {@required this.id,
      @required this.userId,
      @required this.mainImageUrl,
      this.otherImageUrls,
      this.timestamp});

  Map<String, dynamic> toDocument() => {
        'id': id,
        'userId': userId,
        'mainImageUrl': mainImageUrl,
        'timestamp': timestamp,
        'otherImageUrls': otherImageUrls,
      };

  factory ImageModel.fromSnapshot(DocumentSnapshot doc) => ImageModel(
      id: doc.id,
      userId: doc['userId'] as String,
      mainImageUrl: doc['mainImageUrl'] as String,
      timestamp: doc['timestamp'] as Timestamp,
      otherImageUrls: doc['otherImageUrls']);

  @override
  List<Object> get props =>
      [id, userId, mainImageUrl, timestamp, otherImageUrls];
}
