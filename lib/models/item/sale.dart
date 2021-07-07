import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

///
class Sale extends Equatable {
  ///
  const Sale(
      {this.buyerPhone,
      this.buyerAddress,
      this.cartItems,
      this.id,
      this.soldAt});

  ///
  final String id;

  ///
  final String buyerPhone;

  ///
  final String buyerAddress;

  ///
  final List<Map<String, dynamic>> cartItems;

  ///
  final Timestamp soldAt;

  ///
  Sale copyWith(
          {String id,
          String buyerAddress,
          String buyerPhone,
          List<Map<String, dynamic>> cartItems,
          Timestamp soldAt}) =>
      Sale(
          id: id ?? this.id,
          buyerAddress: buyerAddress ?? this.buyerAddress,
          buyerPhone: buyerPhone ?? this.buyerPhone,
          cartItems: cartItems ?? this.cartItems,
          soldAt: soldAt ?? this.soldAt);

  ///
  Map<String, dynamic> toDocument() => {
        'id': id,
        'buyer_phone': buyerPhone,
        'buyer_address': buyerAddress,
        'cart_items': cartItems,
        'sold_at': soldAt
      };

  @override
  List<Object> get props =>
      [id, buyerPhone, buyerAddress, cartItems, soldAt];
}
