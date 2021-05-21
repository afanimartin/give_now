import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ImageModel extends Equatable {
  final String id;
  final String userId;
  final String mainImageUrl;
  final List<String> otherImageUrls;

  ImageModel(
      {@required this.id,
      @required this.userId,
      @required this.mainImageUrl,
      this.otherImageUrls});

  Map<String, dynamic> toDocument() => {
        'id': id,
        'userId': userId,
        'mainImageUrl': mainImageUrl,
        'otherImageUrls': otherImageUrls
      };

  factory ImageModel.fromSnapshot(DocumentSnapshot doc) {
    doc = doc.data();
    return ImageModel(
        id: doc.id,
        userId: doc['userId'] as String,
        mainImageUrl: doc['mainImageUrl'] as String,
        otherImageUrls: doc['otherImageUrls'] as List<String>);
  }

  @override
  List<Object> get props => [id, userId, mainImageUrl, otherImageUrls];
}
