import 'dart:io';

import '../../models/item/item.dart';

///
abstract class IItemRepository {
  ///
  Future<List<String>> uploadItemImagesToStorage(
      List<File> images, String userId);

  ///
  Future<void> uploadItemToFirestore(List<File> urlsToUpload, String userId);

  ///
  Future<void> donateItemToCharity(Item itemToDonate);

  ///
  Stream<List<Item>> currentUserItemStream();
}
