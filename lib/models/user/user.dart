import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

///
class UserModel extends Equatable {
  ///
  const UserModel(
      {this.userId,
      this.email,
      this.displayName,
      this.photoUrl,
      this.phoneNumber,
      this.signedUpAt});

  ///
  factory UserModel.fromSnapshot(DocumentSnapshot doc) => UserModel(
        email: doc['email'] as String,
        displayName: doc['display_name'] as String,
        photoUrl: doc['photo_url'] as String,
      );

  ///
  UserModel copyWith(
          {String displayName, String phoneNumber, bool profileCompleted}) =>
      UserModel(
        displayName: displayName ?? this.displayName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
      );

  ///
  static const empty = UserModel(
    userId: '',
    email: '',
    displayName: '',
    photoUrl: '',
  );

  ///
  final String userId;

  ///
  final String email;

  ///
  final String displayName;

  ///
  final String photoUrl;

  ///
  final String phoneNumber;

  ///
  final Timestamp signedUpAt;

  ///
  Map<String, dynamic> toDocument() => <String, dynamic>{
        'userId': userId,
        'email': email,
        'display_name': displayName,
        'photo_url': photoUrl,
        'phone_number': phoneNumber,
        'signed_up_at': signedUpAt
      };

  @override
  List<Object> get props => [
        userId,
        email,
        displayName,
        photoUrl,
        phoneNumber,
        signedUpAt
      ];
}
