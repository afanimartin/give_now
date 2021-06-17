import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:give_now/helpers/image/image_picker_logic.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../helpers/bloc/current_user_id.dart';
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

  ///
  // void pickAndUploadImages() async {
  //   try {
  //     final _files = await filesToUpload();
  //   } on Exception catch (_) {}
  // }

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
}
