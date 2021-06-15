import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../helpers/bloc/current_user_id.dart';
import '../../models/cart/cart.dart';
import '../../models/item/item.dart';
import '../../repositories/authentication/authentication_repository.dart';
import '../../repositories/item/item_repository.dart';
import '../authentication/authentication_bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';

///
class CartBloc extends Bloc<CartEvent, CartState> {
  ///
  CartBloc({@required ItemRepository itemRepository})
      : _itemRepository = itemRepository,
        super(const CartState());

  ///
  final ItemRepository _itemRepository;

  ///
  StreamSubscription _streamSubscription;

  ///
  final _currentUserId = CurrentUserId(
      authenticationBloc: AuthenticationBloc(
          authenticationRepository: AuthenticationRepository()));

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is LoadCartItems) {
      yield* _mapLoadCartItemsToState();
    } else if (event is UpdateCartItems) {
      yield* _mapUpdateCartItemsToState(event);
    }
  }

  ///
  Stream<CartState> _mapLoadCartItemsToState() async* {
    await _streamSubscription?.cancel();

    _streamSubscription = _itemRepository
        .currentUserCartItems()
        .listen((items) => add(UpdateCartItems(cartItems: items)));
  }

  Stream<CartState> _mapUpdateCartItemsToState(UpdateCartItems event) async* {
    yield CartState(cartItems: event.cartItems);
  }

  ///
  void addItemToCart(Item item) {
    const uuid = Uuid();

    final newCartItem = CartItem(
        id: uuid.v4(),
        buyerId: _currentUserId.getCurrentUserId(),
        sellerId: item.sellerId,
        title: item.title,
        mainImageUrl: item.mainImageUrl,
        price: item.price,
        timestamp: Timestamp.now());

    _itemRepository.addItemToCart(newCartItem);
  }
}
