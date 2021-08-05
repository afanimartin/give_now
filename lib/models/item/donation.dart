import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

///
class Donation extends Equatable {
  ///
  const Donation(
      {required this.id,
      required this.donorId,
      required this.donorPhone,
      required this.mainImageUrl,
      required this.title,
      required this.description,
      required this.category,
      required this.condition,
      required this.donatedAt});

  ///
  final String? id;

  ///
  final String? donorId;

  ///
  final String? donorPhone;

  ///
  final String? mainImageUrl;

  ///
  final String? title;

  ///
  final String? description;

  ///
  final String? category;

  ///
  final String? condition;

  ///
  final Timestamp? donatedAt;

  ///
  Map<String, dynamic> toDocument() => <String, dynamic>{
        'id': id,
        'donor_id': donorId,
        'donor_phone': donorPhone,
        'main_image_url': mainImageUrl,
        'title': title,
        'description': description,
        'category': category,
        'condition': condition,
        'donated_at': donatedAt
      };

  @override
  List<Object?> get props => [
        id,
        donorId,
        donorPhone,
        mainImageUrl,
        title,
        description,
        category,
        condition,
        donatedAt
      ];
}
