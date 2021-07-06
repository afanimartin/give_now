import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/item/item.dart';
import '../../repositories/item/item_repository.dart';
import 'item_event.dart';
import 'item_state.dart';

///
class ItemBloc extends Bloc<ItemEvent, ItemState> {
  ///
  ItemBloc({@required ItemRepository itemRepository})
      : _itemRepository = itemRepository,
        super(const ItemState());

  final ItemRepository _itemRepository;
  StreamSubscription<List<Item>> _itemStreamSubscription;

  @override
  Stream<ItemState> mapEventToState(ItemEvent event) async* {
    if (event is LoadItems) {
      yield* _mapLoadItemsToState();
    } else if (event is UpdateItems) {
      yield* _mapUpdatedItemsToState(event);
    } else if (event is UpdateItem) {
      yield* _mapUpdatedItemToState(event);
    }
  }

  Stream<ItemState> _mapLoadItemsToState() async* {
    try {
      await _itemStreamSubscription?.cancel();

      _itemStreamSubscription = _itemRepository
          .marketplaceStream()
          .listen((items) => add(UpdateItems(items: items)));
    } on Exception catch (error) {
      throw Exception(error);
    }
  }

  Stream<ItemState> _mapUpdatedItemsToState(UpdateItems event) async* {
    yield ItemsLoaded(items: event.items);
  }

  Stream<ItemState> _mapUpdatedItemToState(UpdateItem event) async* {
    try {
      await _itemRepository.updateItem(event.item);
    } on Exception catch (_) {}
  }
}
