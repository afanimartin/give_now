import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/item/item.dart';
import '../../repositories/item/item_repository.dart';
import '../../utils/paths.dart';

///
extension ItemRepositoryExtensions on ItemRepository {
  ///
  static Future<Item> doesItemExist(String collection, String id) async {
    final _firebaseFirestore = FirebaseFirestore.instance;

    final _item = await _firebaseFirestore.collection(collection).doc(id).get();

    return Item.fromSnapshot(_item);
  }

  ///
  static Future<void> donateItem(Item item) async {
    final _firebaseFirestore = FirebaseFirestore.instance;
    final _itemRepository = ItemRepository();

    final itemToDonate = item.copyWith(updatedAt: Timestamp.now());

    await _firebaseFirestore
        .collection(Paths.donations)
        .add(itemToDonate.toDocument());

    await _itemRepository.delete(item);
  }
}
