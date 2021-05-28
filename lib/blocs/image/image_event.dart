import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:give_now/models/image/image_model.dart';

///
class ImageEvent extends Equatable {
  ///
  const ImageEvent();

  @override
  List<Object> get props => [];
}

///
class LoadImages extends ImageEvent {}

///
class AddImage extends ImageEvent {}

///
class UpdateImages extends ImageEvent {
  ///
  const UpdateImages({@required this.images});

  ///
  final List<ImageModel> images;
}
