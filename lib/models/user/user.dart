import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import '../item/item.dart';

///
class UserModel extends Equatable {
  ///
  const UserModel(
      {this.userId,
      this.email,
      this.displayName,
      this.photoUrl,
      this.phoneNumber,
      this.itemsInCart,
      this.itemsPurchased});

  ///
  factory UserModel.fromSnapshot(DocumentSnapshot doc) => UserModel(
      userId: doc.id,
      email: doc['email'] as String,
      displayName: doc['display_name'] as String,
      photoUrl: doc['photo_url'] as String,
      phoneNumber: doc['phone_number'] as String,
      itemsInCart: doc['items_in_cart'] as List<Item>,
      itemsPurchased: doc['items_purchased'] as List<Item>);

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
  final List<Item> itemsInCart;

  ///
  final List<Item> itemsPurchased;

  ///
  Map<String, dynamic> toDocument() => <String, dynamic>{
        'userId': userId,
        'email': email,
        'display_name': displayName,
        'photo_url': photoUrl,
        'phone_number': phoneNumber,
        'items_in_cart': itemsInCart,
        'items_purchased': itemsPurchased
      };

  @override
  List<Object> get props => [
        userId,
        email,
        displayName,
        photoUrl,
        phoneNumber,
        itemsInCart,
        itemsPurchased
      ];
}
