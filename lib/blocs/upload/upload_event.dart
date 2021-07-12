import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../models/item/upload.dart';

///
class UploadEvent extends Equatable {
  ///
  const UploadEvent();

  ///
  @override
  List<Object> get props => [];
}

///
class PickAndPreviewImages extends UploadEvent {}

///
class UploadItem extends UploadEvent {
  ///
  const UploadItem({@required this.upload});

  ///
  final Upload upload;

  ///
  @override
  List<Object> get props => [upload];
}
