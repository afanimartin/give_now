import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/cart/cart.dart';
import '../../models/item/sale.dart';
import '../../utils/paths.dart';
import 'i_cart_repository.dart';

///
class CartRepository extends ICartRepostiory {
  final _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<void> add(CartItem cartItem) async {
    await _firebaseFirestore
        .collection(Paths.carts)
        .doc(cartItem.id)
        .set(cartItem.toDocument());
  }

  @override
  Future<void> delete(CartItem cartItem) async {
    await _firebaseFirestore.collection(Paths.carts).doc(cartItem.id).delete();
  }

  ///
  @override
  Future<void> checkout(Sale sale) async {
    await _firebaseFirestore.collection(Paths.sales).add(sale.toDocument());
  }

  @override
  Stream<List<CartItem>> cart() =>
      _firebaseFirestore.collection(Paths.carts).snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => CartItem.fromSnapshot(doc)).toList());

  ///
  Future<void> docId(String sellerId) => _firebaseFirestore
      .collection(Paths.uploads)
      .where('seller_id', isEqualTo: sellerId)
      .get()
      .then((snapshot) => {snapshot.docs.forEach((doc) => print(doc.id))});
}
