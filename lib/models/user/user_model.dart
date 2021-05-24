import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class UserModel extends Equatable {
  final String userId;
  final String email;
  final String displayName;
  final String photoUrl;

  const UserModel(
      {@required this.userId,
      @required this.email,
      this.displayName,
      this.photoUrl});

  static const empty =
      UserModel(userId: '', email: '', displayName: '', photoUrl: '');

  factory UserModel.fromSnapshot(DocumentSnapshot doc) => UserModel(
      userId: doc.id,
      email: doc['email'] as String,
      displayName: doc['displayName'] as String,
      photoUrl: doc['photoUrl'] as String);

  Map<String, dynamic> toDocument() => <String, dynamic>{
        'userId': userId,
        'email': email,
        'displayName': displayName,
        'photoUrl': photoUrl
      };

  @override
  List<Object> get props => [userId, email, displayName, photoUrl];
}
