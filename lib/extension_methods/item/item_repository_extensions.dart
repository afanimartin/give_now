import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/item/item.dart';
import '../../repositories/item/item_repository.dart';


///
extension ItemRepositoryExtensions on ItemRepository {
  ///
  static Future<Item> doesItemExist(String collection, String id) async {
    final _firebaseFirestore = FirebaseFirestore.instance;

    final _item =
        await _firebaseFirestore.collection(collection).doc(id).get();

    return Item.fromSnapshot(_item);
  }
}
