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
    }
  }

  void uploadImage(File imageToUpload) => _imageRepository.uploadImage(
      imageToUpload, _currentUserId.getCurrentUserId());

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
    yield ImagesUpdated(
        images: event.images, userId: _currentUserId.getCurrentUserId());
  }

  @override
  Future<void> close() {
    _imageStreamSubscription.cancel();

    return super.close();
  }
}
