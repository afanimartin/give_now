import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../extension_methods/upload/upload_repository_extensions.dart';
import '../../models/cart/cart.dart';
import '../../repositories/cart/cart_repository.dart';
import '../../repositories/upload/upload_repository.dart';
import 'cart_event.dart';
import 'cart_state.dart';

///
class CartBloc extends Bloc<CartEvent, CartState> {
  ///
  CartBloc({@required CartRepository cartRepository, FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _cartRepository = cartRepository,
        super(const CartState());

  ///
  final CartRepository _cartRepository;

  ///
  final FirebaseAuth _firebaseAuth;

  ///
  StreamSubscription<List<CartItem>> _streamSubscription;

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is LoadCartItems) {
      yield* _mapLoadCartItemsToState();
    } else if (event is UpdateCartItems) {
      yield* _mapUpdateCartItemsToState(event);
    } else if (event is RemoveItemFromCart) {
      yield* _mapRemoveItemFromCartToState(event);
    } else if (event is AddItemToCart) {
      yield* _mapAddItemToCartToState(event);
    } else if (event is SellItem) {
      yield* _mapSellItemToState(event);
    }
  }

  ///
  Stream<CartState> _mapLoadCartItemsToState() async* {
    await _streamSubscription?.cancel();

    _streamSubscription = _cartRepository
        .cart()
        .listen((items) => add(UpdateCartItems(cartItems: items)));
  }

  Stream<CartState> _mapUpdateCartItemsToState(UpdateCartItems event) async* {
    yield LoadingCartItems();

    try {
      // await _cartRepository.docId();

      yield CartItemsLoaded(cartItems: event.cartItems);
    } on Exception catch (_) {}
  }

  ///
  Stream<CartState> _mapAddItemToCartToState(AddItemToCart event) async* {
    yield AddingItemToCart();

    try {
      // grab item's doc.id and assign to id of cart item
      final cartItem = CartItem(
          id: event.cartItem.id,
          buyerId: _firebaseAuth.currentUser.uid,
          sellerId: event.cartItem.sellerId,
          title: event.cartItem.title,
          mainImageUrl: event.cartItem.mainImageUrl,
          price: event.cartItem.price,
          createdAt: Timestamp.now());

      await _cartRepository.add(cartItem);

      yield ItemSuccessfullyAddedToCart();
    } on Exception catch (_) {}
  }

  ///
  Stream<CartState> _mapRemoveItemFromCartToState(
      RemoveItemFromCart event) async* {
    yield ItemBeingRemovedFromCart();

    try {
      await _cartRepository.delete(event.item);
    } on Exception catch (_) {}
  }

  ///
  Stream<CartState> _mapSellItemToState(SellItem event) async* {
    const uuid = Uuid();
    try {
      final _sale = event.sale.copyWith(
          id: uuid.v4(),
          buyerAddress: event.sale.buyerAddress,
          buyerPhone: event.sale.buyerPhone,
          cartItems: event.sale.cartItems,
          soldAt: Timestamp.now());

      await _cartRepository.checkout(_sale);
    } on Exception catch (_) {}
  }

  ///
  void updateUploadQuantity(List<CartItem> cartItems) async {
    final _uploadRepository = UploadRepository();

    for (var i = 0; i < cartItems.length; i++) {
      final _item =
          await UploadRepositoryExtensions.doesItemExist(cartItems[i].sellerId);

      // if item exists, update it's quantity
      if (_item != null) {
        final _quantity = int.parse(_item.quantity) - 1;
        final _updated = _item.copyWith(quantity: _quantity as String);

        await _uploadRepository.update(_updated);
      }
    }
  }

  ///
  void deleteCartItems(List<CartItem> cartItems) {
    for (var i = 0; i < cartItems.length; i++) {
      _cartRepository.delete(cartItems[i]);
    }
  }
}
