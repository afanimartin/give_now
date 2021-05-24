import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:give_now/models/image/image_model.dart';

class ImageState extends Equatable {
  const ImageState();

  @override
  List<Object> get props => [];
}

class ImagesUpdated extends ImageState {
  final List<ImageModel> images;
  final FirebaseAuth _firebaseAuth;

  ImagesUpdated({@required this.images, FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  List<ImageModel> get currentUserImages => images
      .where((image) => image.userId == _firebaseAuth.currentUser.uid)
      .toList();

  @override
  List<Object> get props => [images];
}

class ImageIsAdding extends ImageState {}
