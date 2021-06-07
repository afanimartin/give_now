import 'dart:io';

import '../../models/item/item_model.dart';

///
abstract class IItemRepository {
  ///
  Future<List<String>> uploadItemImagesToStorage(
      List<File> images, String userId);

  ///
  Future<void> uploadItemToFirestore(List<File> urlsToUpload, String userId);

  ///
  Future<void> donateItemToCharity(ItemModel itemToDonate);

  ///
  Stream<List<ItemModel>> currentUserItemStream(String userId);
}
