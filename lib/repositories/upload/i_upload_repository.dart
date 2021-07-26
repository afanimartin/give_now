import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/item/item.dart';

///
abstract class IUploadRepository {
  ///
  Future<void> upload(Item upload, FirebaseFirestore firebaseFirestore);

  ///
  Future<void> update(Item item);

  ///
  Future<void> delete(Item item);

  ///
  Stream<List<Item>> uploads();
}
