import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  Stream<CartState> mapEventToState(CartEvent event) async* {}
}
