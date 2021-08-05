import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

///
class Item extends Equatable {
  ///
  const Item(
      {this.sellerPhoneNumber,
      this.title,
      this.description,
      this.price,
      this.category,
      this.sellerId,
      this.sellerPhotoUrl,
      this.mainImageUrl,
      this.id,
      this.quantity = '1',
      this.condition = 'used',
      this.buyerId,
      this.buyerAddress,
      this.buyerPhoneNumber,
      this.otherImageUrls,
      this.cartItems,
      this.createdAt,
      this.updatedAt});

  ///
  factory Item.fromSnapshot(DocumentSnapshot doc) => Item(
        id: doc.id,
        buyerId: doc['buyer_id'] as String? ?? '',
        sellerId: doc['seller_id'] as String? ?? '',
        sellerPhotoUrl: doc['seller_photo_url'] as String?,
        sellerPhoneNumber: doc['seller_phone_number'] as String?,
        title: doc['title'] as String?,
        description: doc['description'] as String?,
        quantity: doc['quantity'] as String?,
        condition: doc['condition'] as String?,
        price: doc['price'] as String?,
        category: doc['category'] as String?,
        mainImageUrl: doc['main_image_url'] as String?,
        otherImageUrls: doc['other_image_urls'] as List<dynamic>?,
        createdAt: doc['created_at'] as Timestamp?,
        updatedAt: doc['updated_at'] as Timestamp?,
      );

  ///
  final String? id;

  ///
  final String? sellerId;

  ///
  final String? sellerPhotoUrl;

  ///
  final String? sellerPhoneNumber;

  ///
  final String? buyerId;

  ///
  final String? buyerAddress;

  ///
  final String? buyerPhoneNumber;

  ///
  final String? title;

  ///
  final String? description;

  ///
  final String? quantity;

  ///
  final String? condition;

  ///
  final String? price;

  ///
  final String? category;

  ///
  final String? mainImageUrl;

  ///
  final List<dynamic>? otherImageUrls;

  ///
  final List<Map<String, dynamic>>? cartItems;

  ///
  final Timestamp? createdAt;

  ///
  final Timestamp? updatedAt;

  ///
  Map<String, dynamic> toDocument() => <String, dynamic>{
        'id': id,
        'buyer_id': buyerId,
        'seller_id': sellerId,
        'seller_photo_url': sellerPhotoUrl,
        'seller_phone_number': sellerPhoneNumber,
        'title': title,
        'description': description,
        'quantity': quantity,
        'condition': condition,
        'price': price,
        'category': category,
        'main_image_url': mainImageUrl,
        'other_image_urls': otherImageUrls,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };

  ///
  Map<String, dynamic> toSaleDocument() => <String, dynamic>{
        'id': id,
        'buyer_id': buyerId,
        'buyer_address': buyerAddress,
        'buyer_phone_number': buyerPhoneNumber,
        'seller_id': sellerId,
        'seller_phone_number': sellerPhoneNumber,
        'cart_items': cartItems,
        'sold_at': createdAt,
      };

  ///
  Item copyWith(
          {String? id,
          String? sellerId,
          String? sellerPhotoUrl,
          String? sellerPhoneNumber,
          String? buyerId,
          String? buyerAddress,
          String? buyerPhoneNumber,
          String? title,
          String? description,
          String? quantity,
          String? condition,
          String? price,
          String? category,
          String? mainImageUrl,
          Timestamp? createdAt,
          Timestamp? updatedAt,
          List<dynamic>? otherImageUrls,
          List<Map<String, dynamic>>? cartItems}) =>
      Item(
        id: id ?? this.id,
        sellerId: sellerId ?? this.sellerId,
        sellerPhotoUrl: sellerPhotoUrl ?? this.sellerPhotoUrl,
        sellerPhoneNumber: sellerPhoneNumber ?? this.sellerPhoneNumber,
        buyerId: buyerId ?? this.buyerId,
        buyerAddress: buyerAddress ?? this.buyerAddress,
        buyerPhoneNumber: buyerPhoneNumber ?? buyerPhoneNumber,
        title: title ?? this.title,
        description: description ?? this.description,
        quantity: quantity ?? this.quantity,
        condition: condition ?? this.condition,
        price: price ?? this.price,
        category: category ?? this.category,
        mainImageUrl: mainImageUrl ?? this.mainImageUrl,
        otherImageUrls: otherImageUrls ?? this.otherImageUrls,
        cartItems: cartItems ?? this.cartItems,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  @override
  List<Object?> get props => [
        id,
        sellerId,
        sellerPhotoUrl,
        sellerPhoneNumber,
        buyerId,
        buyerAddress,
        buyerPhoneNumber,
        title,
        description,
        quantity,
        condition,
        price,
        mainImageUrl,
        otherImageUrls,
        cartItems,
        createdAt,
        updatedAt,
      ];
}
