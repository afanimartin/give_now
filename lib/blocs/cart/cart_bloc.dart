import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/items/items.dart';
import '../../repositories/item/item_repository.dart';
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

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is LoadCartItems) {
      yield* _mapLoadCartItemsToState();
    } else if (event is RemoveItemFromCart) {
      yield* _mapRemoveItemFromCartToState(event);
    }
  }

  Stream<CartState> _mapLoadCartItemsToState() async* {
    try {
      yield CartState(cartItems: itemsForSale);
    } on Exception catch (_) {}
  }

  Stream<CartState> _mapRemoveItemFromCartToState(
      RemoveItemFromCart event) async* {
    final newList = itemsForSale..remove(event.item);

    yield CartState(cartItems: newList);
  }
}
