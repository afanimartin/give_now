import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import '../../models/item/item.dart';
import '../../models/item/upload.dart';

///
final firebaseStorage = FirebaseStorage.instance;

///
Future<List<String>> getDownloadURL(List<File> images) async {
  ///
  final imageUrls = <String>[];

  ///
  const uuid = Uuid();

  for (var i = 0; i < images.length; i++) {
    final _ref = await firebaseStorage
        .ref()
        .child('images/${uuid.v4()}')
        .putFile(images[i]);

    final _url = await _ref.ref.getDownloadURL();
    imageUrls.add(_url);
  }

  return imageUrls;
}

///
Item convertUploadToItem(Upload upload, List<String> imageUrls) {
  final item = Item(
      id: upload.id,
      sellerId: upload.sellerId,
      sellerPhotoUrl: upload.sellerPhotoUrl,
      title: upload.title,
      description: upload.description,
      category: upload.category,
      condition: upload.condition,
      price: upload.price,
      sellerPhoneNumber: upload.phone,
      mainImageUrl: imageUrls[0],
      createdAt: Timestamp.now(),
      otherImageUrls: imageUrls.sublist(1));
  return item;
}
