import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/item/item.dart';

import '../../utils/paths.dart';
import 'i_cart_repository.dart';

///
class CartRepository extends ICartRepostiory {
  final _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<void> add(Item item) async {
    await _firebaseFirestore
        .collection(Paths.carts)
        .doc(item.id)
        .set(item.toDocument());
  }

  @override
  Future<void> update(Item item) async {
    await _firebaseFirestore
        .collection(Paths.carts)
        .doc(item.id)
        .update(item.toDocument());
  }

  @override
  Future<void> delete(Item item) async {
    await _firebaseFirestore.collection(Paths.carts).doc(item.id).delete();
  }

  ///
  @override
  Future<void> checkout(Item sale) async {
    await _firebaseFirestore
        .collection(Paths.sales)
        .doc(sale.id)
        .set(sale.toSaleDocument());
  }

  @override
  Stream<List<Item>> cart() =>
      _firebaseFirestore.collection(Paths.carts).snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => Item.fromSnapshot(doc)).toList());
}
