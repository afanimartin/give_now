import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/item/item.dart';

import '../../repositories/upload/upload_repository.dart';
import '../../utils/paths.dart';

///
extension UploadRepositoryExtensions on UploadRepository {
  ///
  static Future<Item> doesItemExist(String sellerId) async {
    final _firebaseFirestore = FirebaseFirestore.instance;

    final _item =
        await _firebaseFirestore.collection(Paths.uploads).doc(sellerId).get();

    return Item.fromSnapshot(_item);
  }
}
