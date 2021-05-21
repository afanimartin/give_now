import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:give_now/blocs/authentication/authentication_bloc.dart';
import 'package:give_now/blocs/image/image_state.dart';
import 'package:give_now/helpers/bloc/current_user_id.dart';
import 'package:give_now/repositories/authentication/authentication_repository.dart';
import 'package:give_now/repositories/image_upload/image_repository.dart';

class ImageCubit extends Cubit<ImageState> {
  final ImageRepository _imageUploadRepository;

  ImageCubit({@required ImageRepository imageUploadRepository})
      : _imageUploadRepository = imageUploadRepository,
        super(ImageState());

  final _currentUserId = CurrentUserId(
      authenticationBloc: AuthenticationBloc(
          authenticationRepository: AuthenticationRepository()));

  void uploadImage(File imageToUpload) => _imageUploadRepository.uploadImage(
      imageToUpload, _currentUserId.getCurrentUserId());
}
