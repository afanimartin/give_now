import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../helpers/bloc/current_user_id.dart';
import '../../repositories/authentication/authentication_repository.dart';
import '../../repositories/image_upload/item_repository.dart';
import '../authentication/authentication_bloc.dart';
import 'item_event.dart';
import 'item_state.dart';

///
class ItemBloc extends Bloc<ItemEvent, ItemState> {
  ///
  ItemBloc({@required ItemRepository imageRepository})
      : _imageRepository = imageRepository,
        super(const ItemState());

  final _currentUserId = CurrentUserId(
      authenticationBloc: AuthenticationBloc(
          authenticationRepository: AuthenticationRepository()));

  final ItemRepository _imageRepository;
  StreamSubscription _imageStreamSubscription;

  @override
  Stream<ItemState> mapEventToState(ItemEvent event) async* {
    if (event is LoadImages) {
      yield* _mapLoadImagesToState();
    } else if (event is UpdateImages) {
      yield* _mapUpdatedImagesToState(event);
    } else if (event is AddImage) {
      // yield* _mapAddImageToState();
    }
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

        await _imageRepository.uploadItemToFirestore(
            files, _currentUserId.getCurrentUserId());
      }
    } on Exception catch (_) {}
  }

  Stream<ItemState> _mapLoadImagesToState() async* {
    try {
      await _imageStreamSubscription?.cancel();

      final userId = _currentUserId.getCurrentUserId();

      _imageStreamSubscription = _imageRepository
          .imageStream(userId)
          .listen((images) => add(UpdateImages(images: images)));
    } on Exception catch (error) {
      throw Exception(error);
    }
  }

  Stream<ItemState> _mapUpdatedImagesToState(UpdateImages event) async* {
    yield ItemUpdated(images: event.images);
  }

  @override
  Future<void> close() {
    _imageStreamSubscription.cancel();

    return super.close();
  }
}
