import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String displayName;
  final String photoUrl;

  const UserModel(
      {@required this.id,
      @required this.email,
      @required this.displayName,
      @required this.photoUrl});

  static const empty =
      UserModel(id: '', email: '', displayName: '', photoUrl: '');

  @override
  List<Object> get props => [id, email];
}
