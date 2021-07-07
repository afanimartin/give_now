import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import '../../models/cart/cart.dart';
import '../../models/item/item.dart';
import '../../models/item/sale.dart';
import '../../models/item/upload.dart';
import '../../utils/paths.dart';
import 'i_item_repository.dart';

///
class ItemRepository extends IItemRepository {
  final _firebaseStorage = FirebaseStorage.instance;
  final _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<List<String>> uploadItemImagesToStorage(List<File> images) async {
    const uuid = Uuid();
    final imageUrls = <String>[];

    // make this an extension method
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
      Upload upload, List<File> urlsToUpload) async {
    final imageUrls = await uploadItemImagesToStorage(urlsToUpload);

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

    await _firebaseFirestore.collection(Paths.uploads).add(item.toDocument());
  }

  /// make this an extension method
  @override
  Future<void> addItemToCart(CartItem cartItem) async {
    await _firebaseFirestore.collection(Paths.carts).add(cartItem.toDocument());
  }

  /// make this an extension method
  Future<void> removeItemFromCart(CartItem cartItem) async {
    await _firebaseFirestore.collection(Paths.carts).doc(cartItem.id).delete();
  }

  ///
  Future<void> updateItem(Item item) async {
    await _firebaseFirestore
        .collection(Paths.uploads)
        .doc(item.id)
        .update(item.toDocument());
  }

  ///
  Future<void> buyItems(Sale sale) async {
    await _firebaseFirestore.collection(Paths.sales).add(sale.toDocument());
  }

  ///
  Stream<List<CartItem>> currentUserCartItems() =>
      _firebaseFirestore.collection(Paths.carts).snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => CartItem.fromSnapshot(doc)).toList());

  @override
  Stream<List<Item>> marketplaceStream() {
    final items = _firebaseFirestore.collection(Paths.uploads).snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Item.fromSnapshot(doc)).toList()
              ..sort((a, b) => b.createdAt.compareTo(a.createdAt)));
    return items;
  }

  ///
  Stream<List<Item>> currentUserDonations(String userId) => _firebaseFirestore
      .collection(Paths.donations)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Item.fromSnapshot(doc)).toList()
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt)));
}
