import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import '../../models/cart/cart.dart';
import '../../models/item/item.dart';
import '../../utils/paths.dart';
import 'i_item_repository.dart';

///
class ItemRepository extends IItemRepository {
  final _firebaseStorage = FirebaseStorage.instance;
  final _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<List<String>> uploadItemImagesToStorage(
      List<File> images, String userId) async {
    const uuid = Uuid();
    final imageUrls = <String>[];

    for (var i = 0; i < images.length; i++) {
      final _ref = await _firebaseStorage
          .ref()
          .child('images/${uuid.v4()}')
          .putFile(images[i]);

      final _url = await _ref.ref.getDownloadURL();
      imageUrls.add(_url);
    }

    return imageUrls;
  }

  @override
  Future<void> uploadItemToFirestore(
      List<File> urlsToUpload, String userId) async {
    const uuid = Uuid();

    final imageUrls = await uploadItemImagesToStorage(urlsToUpload, userId);

    final item = Item(
        id: uuid.v4(),
        sellerId: userId,
        mainImageUrl: imageUrls[0],
        timestamp: Timestamp.now(),
        otherImageUrls: imageUrls.sublist(1));

    await _firebaseFirestore.collection(Paths.uploads).add(item.toDocument());
  }

  @override
  Future<void> addItemToCart(CartItem item) async {
    await _firebaseFirestore.collection(Paths.carts).add(item.toDocument());
  }

  ///
  Stream<List<CartItem>> currentUserCartItems() =>
      _firebaseFirestore.collection(Paths.carts).snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => CartItem.fromSnapshot(doc)).toList());

  @override
  Future<void> donateItemToCharity(Item itemToDonate) async {
    await _firebaseFirestore
        .collection(Paths.donations)
        .add(itemToDonate.toDocument());

    await _firebaseFirestore
        .collection(Paths.uploads)
        .doc(itemToDonate.id)
        .delete();

    await _firebaseFirestore
        .collection(Paths.uploads)
        .add(itemToDonate.toDocument());
  }

  @override
  Stream<List<Item>> marketplaceStream() {
    final items = _firebaseFirestore.collection(Paths.uploads).snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Item.fromSnapshot(doc)).toList()
              ..sort((a, b) => b.timestamp.compareTo(a.timestamp)));
    return items;
  }

  ///
  Stream<List<Item>> currentUserDonations(String userId) => _firebaseFirestore
      .collection(Paths.donations)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Item.fromSnapshot(doc)).toList()
            ..sort((a, b) => b.timestamp.compareTo(a.timestamp)));
}
