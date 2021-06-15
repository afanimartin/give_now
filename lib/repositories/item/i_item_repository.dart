import 'dart:io';

import 'package:give_now/models/cart/cart.dart';

import '../../models/item/item.dart';

///
abstract class IItemRepository {
  ///
  Future<List<String>> uploadItemImagesToStorage(
      List<File> images, String userId);

  ///
  Future<void> uploadItemToFirestore(List<File> urlsToUpload, String userId);

  ///
  Future<void> addItemToCart(CartItem item);

  ///
  Future<void> donateItemToCharity(Item itemToDonate);

  ///
  Stream<List<Item>> marketplaceStream();
}
