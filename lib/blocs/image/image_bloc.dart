import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:give_now/blocs/authentication/authentication_bloc.dart';
import 'package:give_now/blocs/image/image_event.dart';
import 'package:give_now/blocs/image/image_state.dart';
import 'package:give_now/helpers/bloc/current_user_id.dart';
import 'package:give_now/repositories/authentication/authentication_repository.dart';
import 'package:give_now/repositories/image_upload/image_repository.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final ImageRepository _imageRepository;
  StreamSubscription _imageStreamSubscription;

  ImageBloc({@required ImageRepository imageRepository})
      : _imageRepository = imageRepository,
        super(const ImageState());

  final _currentUserId = CurrentUserId(
      authenticationBloc: AuthenticationBloc(
          authenticationRepository: AuthenticationRepository()));

  @override
  Stream<ImageState> mapEventToState(event) async* {
    if (event is LoadImages) {
      yield* _mapLoadImagesToState();
    } else if (event is UpdateImages) {
      yield* _mapUpdatedImagesToState(event);
    } else if (event is AddImage) {
      // yield* _mapAddImageToState();
    }
  }

  void uploadImages() async {
    try {
      final files = <File>[];
      List<Asset> images = [];

      await Permission.photos.request();

      final permissionStatus = await Permission.photos.status;

      final appDocDir = await getTemporaryDirectory();
      final appDocPath = appDocDir.path;

      if (permissionStatus.isGranted) {
        images = await MultiImagePicker.pickImages(
            maxImages: 5, selectedAssets: images);

        for (int i = 0; i < images.length; i++) {
          final byteData = await images[i].getByteData();

          final tempFile = File('$appDocPath/${images[i].name}');

          final file = await tempFile.writeAsBytes(byteData.buffer
              .asInt8List(byteData.offsetInBytes, byteData.lengthInBytes));

          files.add(file);
        }

        await _imageRepository.uploadImageUrlsToFirestore(
            files, _currentUserId.getCurrentUserId());
      }
    } on Exception catch (_) {}
  }

  Stream<ImageState> _mapLoadImagesToState() async* {
    try {
      await _imageStreamSubscription?.cancel();

      final userId = _currentUserId.getCurrentUserId();

      _imageStreamSubscription = _imageRepository
          .imageStream(userId)
          .listen((images) => add(UpdateImages(images: images)));
    } catch (error) {
      throw Exception(error);
    }
  }

  Stream<ImageState> _mapUpdatedImagesToState(UpdateImages event) async* {
    yield ImagesUpdated(images: event.images);
  }

  @override
  Future<void> close() {
    _imageStreamSubscription.cancel();

    return super.close();
  }
}
