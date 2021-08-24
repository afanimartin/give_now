import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/item/item.dart';
import '../../repositories/cart/cart_repository.dart';
import '../../repositories/item/item_repository.dart';
import 'cart_state.dart';

///
class CartCubit extends Cubit<CartState> {
  ///
  CartCubit(
      {required CartRepository cartRepository,
      required ItemRepository itemRepository,
      FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _cartRepository = cartRepository,
        _itemRepository = itemRepository,
        super(const CartState());

  ///
  final CartRepository _cartRepository;

  ///
  final ItemRepository _itemRepository;

  ///
  final FirebaseAuth _firebaseAuth;

  ///
  StreamSubscription<List<Item>>? _streamSubscription;

  ///
  void loadCartItems() async {
    await _streamSubscription?.cancel();

    _streamSubscription = _cartRepository
        .cart()
        .listen((items) => emit(CartItemsLoaded(items: items)));
  }

  ///
  void updateCartItems(List<Item> items) {
     emit(LoadingCartItems());

    try {
      emit(CartItemsLoaded(items: items));
    } on Exception catch (_) {}
  }

  ///
  void addItemToCart(Item item) async {
     emit(AddingItemToCart());

    try {
      final _item = item.copyWith(
          buyerId: _firebaseAuth.currentUser!.uid, createdAt: Timestamp.now());

      await _cartRepository.add(_item);
    } on Exception catch (_) {}
  }

  ///
  void removeItemFromCart(
      Item item) async {
    emit(ItemBeingRemovedFromCart());

    try {
      await _cartRepository.delete(item);
    } on Exception catch (_) {}
  }

  ///
  void sellItem(Item item) async {
    try {
      final _sale = item.copyWith(
          buyerId: _firebaseAuth.currentUser!.uid,
          buyerAddress: item.buyerAddress,
          buyerPhoneNumber: item.buyerPhoneNumber,
          sellerId: item.sellerId,
          sellerPhoneNumber: item.sellerPhoneNumber,
          cartItems: item.cartItems,
          createdAt: Timestamp.now());

      await _cartRepository.checkout(_sale);
    } on Exception catch (_) {}
  }

  ///
  Future<void> deleteCartItems(List<Item> cartItems) async {
    for (var i = 0; i < cartItems.length; i++) {
      await _cartRepository.delete(cartItems[i]);
    }
  }

  ///
  Future<void> decrementItemQuantity(List<Item> cartItems) async {
    for (var i = 0; i < cartItems.length; i++) {
      final _item = cartItems[i];
      final _quantity = int.parse(_item.quantity!) - 1;

      final _updatedItem = _item.copyWith(quantity: _quantity.toString());

      await _itemRepository.update(_updatedItem);
    }
  }
}
