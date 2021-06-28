import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

///
class Upload extends Equatable {
  ///
  const Upload({
    @required this.title,
    @required this.description,
    @required this.condition,
    @required this.price,
    @required this.category,
    this.id,
    this.sellerId,
    this.sellerPhotoUrl,
  });

  ///
  final String id;

  ///
  final String sellerId;

  ///
  final String sellerPhotoUrl;

  ///
  final String title;

  ///
  final String description;

  ///
  final String condition;

  ///
  final String price;

  ///
  final String category;

  @override
  List<Object> get props => [
        id,
        sellerId,
        sellerPhotoUrl,
        title,
        description,
        condition,
        price,
        category
      ];

  ///
  Upload copyWith(
          {String id,
          String sellerId,
          String sellerPhotoUrl,
          String title,
          String description,
          String condition,
          String price,
          String category}) =>
      Upload(
          id: id ?? this.id,
          sellerId: sellerId ?? this.sellerId,
          sellerPhotoUrl: sellerPhotoUrl ?? this.sellerPhotoUrl,
          title: title ?? this.title,
          description: description ?? this.description,
          condition: condition ?? this.condition,
          price: price ?? this.price,
          category: category ?? this.category);
}
