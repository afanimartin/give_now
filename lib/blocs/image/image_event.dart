import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:give_now/models/image/image_model.dart';

class ImageEvent extends Equatable {
  const ImageEvent();

  @override
  List<Object> get props => [];
}

class LoadImages extends ImageEvent {}

class AddImage extends ImageEvent {
  final File imageToUpload;

  const AddImage({@required this.imageToUpload});

  @override
  List<Object> get props => [imageToUpload];
}

class UpdateImages extends ImageEvent {
  final List<ImageModel> images;

  const UpdateImages({@required this.images});
}
