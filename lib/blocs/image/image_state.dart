import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:give_now/models/image/image_model.dart';

class ImageState extends Equatable {
  const ImageState();

  @override
  List<Object> get props => [];
}

class ImagesUpdated extends ImageState {
  final List<ImageModel> images;
  final String userId;

  const ImagesUpdated({@required this.images, @required this.userId});

  @override
  List<Object> get props => [images, userId];
}
