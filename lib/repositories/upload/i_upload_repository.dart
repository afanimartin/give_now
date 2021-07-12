import 'dart:io';

import '../../models/item/item.dart';
import '../../models/item/upload.dart';

///
abstract class IUploadRepository {
  ///
  Future<void> upload(Upload upload, List<File> urlsToUpload);

  ///
  Future<void> update(Item item);

  ///
  Future<void> delete(Item item);

  ///
  Stream<List<Item>> uploads();
}
