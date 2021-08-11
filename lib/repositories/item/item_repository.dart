import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/item/item.dart';
import '../../utils/paths.dart';
import 'i_item_repository.dart';

///
class ItemRepository extends IItemRepository {
  final _firebaseFirestore = FirebaseFirestore.instance;

  ///
  @override
  Future<void> add(Item item) async {
    await _firebaseFirestore
        .collection(Paths.uploads)
        .doc(item.id)
        .set(item.toDocument());
  }

  ///
  @override
  Future<void> update(Item item) async {
    await _firebaseFirestore
        .collection(Paths.uploads)
        .doc(item.id)
        .update(item.toDocument());
  }

  ///
  @override
  Future<void> delete(Item item) async {
    await _firebaseFirestore.collection(Paths.uploads).doc(item.id).delete();
  }

  ///
  @override
  Stream<List<Item>> allItems() =>
      _firebaseFirestore.collection(Paths.uploads).snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => Item.fromSnapshot(doc)).toList()
            ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!)));
}
