import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../helpers/bloc/current_user_id.dart';
import '../../models/image/item_model.dart';
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
  StreamSubscription _imageStreamSubscription;

  @override
  Stream<ItemState> mapEventToState(ItemEvent event) async* {
    if (event is LoadItems) {
      yield* _mapLoadImagesToState();
    } else if (event is UpdateItems) {
      yield* _mapUpdatedImagesToState(event);
    } else if (event is AddItem) {
      // yield* _mapAddImageToState();
    }
  }

  ///
  void donateItemToCharity(ItemModel itemToDonate) {
    final updatedItem = itemToDonate.copyWith(
        id: itemToDonate.id,
        userId: itemToDonate.userId,
        donated: !itemToDonate.donated,
        mainImageUrl: itemToDonate.mainImageUrl,
        otherImageUrls: itemToDonate.otherImageUrls,
        timestamp: Timestamp.now());

    _itemRepository.donateItemToCharity(updatedItem);
  }

  ///
  void pickAnUploadImages() async {
    try {
      final files = <File>[];

      ///
      var images = <Asset>[];

      await Permission.photos.request();

      final permissionStatus = await Permission.photos.status;

      final appDocDir = await getTemporaryDirectory();
      final appDocPath = appDocDir.path;

      if (permissionStatus.isGranted) {
        images = await MultiImagePicker.pickImages(
            maxImages: 5, selectedAssets: images);

        for (var i = 0; i < images.length; i++) {
          final byteData = await images[i].getByteData();

          final tempFile = File('$appDocPath/${images[i].name}');

          final file = await tempFile.writeAsBytes(byteData.buffer
              .asInt8List(byteData.offsetInBytes, byteData.lengthInBytes));

          files.add(file);
        }

        await _itemRepository.uploadItemToFirestore(
            files, _currentUserId.getCurrentUserId());
      }
    } on Exception catch (_) {}
  }

  Stream<ItemState> _mapLoadImagesToState() async* {
    try {
      await _imageStreamSubscription?.cancel();

      final userId = _currentUserId.getCurrentUserId();

      _imageStreamSubscription = _itemRepository
          .currentUserItemStream(userId)
          .listen((images) => add(UpdateItems(items: images)));
    } on Exception catch (error) {
      throw Exception(error);
    }
  }

  Stream<ItemState> _mapUpdatedImagesToState(UpdateItems event) async* {
    yield ItemUpdated(items: event.items);
  }

  @override
  Future<void> close() {
    _imageStreamSubscription.cancel();

    return super.close();
  }
}
