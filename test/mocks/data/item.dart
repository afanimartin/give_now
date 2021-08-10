import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moostamil/models/item/item.dart';

final mockedUploads = <Item>[];

final itemOne = Item(
  id: 's5yyU7pIhddMcxZirIv3',
  buyerId: 'buyer_id',
  sellerId: 'seller_id',
  sellerPhotoUrl: 'seller_photo_url',
  sellerPhoneNumber: 'seller_phone_number',
  title: 'item one title',
  description: 'item one description',
  price: '20000',
  category: 'animal',
  mainImageUrl: 'main_image_url',
  otherImageUrls: const <dynamic>['other_image_url_one'],
  createdAt: Timestamp.now(),
  updatedAt: Timestamp.now(),
);

final itemTwo = Item(
  id: 'Vv6c4E39yID0Ovpfbabz',
  buyerId: '',
  sellerId: '',
  sellerPhotoUrl: '',
  sellerPhoneNumber: '',
  title: 'item two title',
  description: 'item two description',
  price: '25000',
  category: 'car',
  mainImageUrl: '',
  otherImageUrls: const <dynamic>[],
  createdAt: Timestamp.now(),
  updatedAt: Timestamp.now(),
);
