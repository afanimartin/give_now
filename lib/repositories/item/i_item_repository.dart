import 'dart:io';

import '../../models/cart/cart.dart';
import '../../models/item/item.dart';
import '../../models/item/upload.dart';

///
abstract class IItemRepository {
  ///
  Future<List<String>> uploadItemImagesToStorage(List<File> images);

  ///
  Future<void> uploadItemToFirestore(Upload upload, List<File> urlsToUpload);

  ///
  Future<void> addItemToCart(CartItem item);

  ///
  Stream<List<Item>> marketplaceStream();
}
