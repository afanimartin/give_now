import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../helpers/repository/item_repository_helper.dart';

import '../../models/cart/cart.dart';
import '../../models/item/donation.dart';
import '../../models/item/item.dart';
import '../../models/item/sale.dart';
import '../../models/item/upload.dart';
import '../../utils/paths.dart';
import 'i_item_repository.dart';

///
class ItemRepository extends IItemRepository {
  // final _firebaseStorage = FirebaseStorage.instance;
  final _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<List<String>> uploadItemImagesToStorage(List<File> images) async {
    final _imageUrls = await getDownloadURL(images);

    return _imageUrls;
  }

  @override
  Future<void> uploadItemToFirestore(
      Upload upload, List<File> urlsToUpload) async {
    final imageUrls = await uploadItemImagesToStorage(urlsToUpload);

    final item = convertUploadToItem(upload, imageUrls);

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
  Future<void> deleteItem(Item item) async {
    await _firebaseFirestore.collection(Paths.uploads).doc(item.id).delete();
  }

  ///
  Future<void> buyItems(Sale sale) async {
    await _firebaseFirestore.collection(Paths.sales).add(sale.toDocument());
  }

  ///
  Future<void> donateItem(Item item) async {
    final _donation = Donation(
        id: item.id,
        donorId: item.sellerId,
        donorPhone: item.sellerPhoneNumber,
        mainImageUrl: item.mainImageUrl,
        title: item.title,
        description: item.description,
        category: item.category,
        condition: item.condition,
        donatedAt: item.createdAt);

    await _firebaseFirestore
        .collection(Paths.donations)
        .add(_donation.toDocument());

    final _item = item.copyWith(isDonated: true);

    await updateItem(_item);
  }

  ///
  Stream<List<CartItem>> cartItems() =>
      _firebaseFirestore.collection(Paths.carts).snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => CartItem.fromSnapshot(doc)).toList());

  @override
  Stream<List<Item>> marketplaceStream() =>
      _firebaseFirestore.collection(Paths.uploads).snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => Item.fromSnapshot(doc)).toList()
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt)));

  ///
  Stream<List<Item>> currentUserDonations(String userId) => _firebaseFirestore
      .collection(Paths.donations)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Item.fromSnapshot(doc)).toList()
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt)));
}
