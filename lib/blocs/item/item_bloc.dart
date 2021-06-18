import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../helpers/bloc/current_user_id.dart';
import '../../helpers/image/image_picker_logic.dart';
import '../../models/form/item_form.dart';
import '../../models/item/item.dart';
import '../../repositories/authentication/authentication_repository.dart';
import '../../repositories/item/item_repository.dart';
import '../authentication/authentication_bloc.dart';
import 'item_event.dart';
import 'item_state.dart';

///
class ItemBloc extends Bloc<ItemEvent, ItemState> {
  ///
  ItemBloc({@required ItemRepository itemRepository})
      : _itemRepository = itemRepository,
        super(const ItemState());

  final _currentUserId = CurrentUserId(
      authenticationBloc: AuthenticationBloc(
          authenticationRepository: AuthenticationRepository()));

  final ItemRepository _itemRepository;
  StreamSubscription<List<Item>> _itemStreamSubscription;

  @override
  Stream<ItemState> mapEventToState(ItemEvent event) async* {
    if (event is LoadItems) {
      yield* _mapLoadItemsToState();
    } else if (event is UpdateItems) {
      yield* _mapUpdatedImagesToState(event);
    } else if (event is PickAndUploadItems) {
      yield* _mapPickAndUploadItemsToState();
    }
  }

  Stream<ItemState> _mapPickAndUploadItemsToState() async* {
    yield ItemIsBeingAdded();

    try {
      final _files = await filesToUpload();

      yield ImagesToUploadPicked(images: _files);
    } on Exception catch (_) {}
  }

  ///
  void donateItemToCharity(Item itemToDonate) {
    final updatedItem = itemToDonate.copyWith(
        id: itemToDonate.id,
        sellerId: itemToDonate.sellerId,
        isDonated: true,
        mainImageUrl: itemToDonate.mainImageUrl,
        otherImageUrls: itemToDonate.otherImageUrls,
        timestamp: Timestamp.now());

    _itemRepository.donateItemToCharity(updatedItem);
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

  Stream<ItemState> _mapUpdatedImagesToState(UpdateItems event) async* {
    yield ItemUpdated(items: event.items);
  }

  void titleChanged(String value) {
    final title = ItemForm.dirty(value: value);
    emit(state.copyWith(
        title: title, formzStatus: Formz.validate([title, state.description])));
  }

  void descriptionChanged(String value) {
    final description = ItemForm.dirty(value: value);
    emit(state.copyWith(
        description: description,
        formzStatus: Formz.validate([description, state.title])));
  }
}
