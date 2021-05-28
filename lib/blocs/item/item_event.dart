import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../models/image/item_model.dart';

///
class ItemEvent extends Equatable {
  ///
  const ItemEvent();

  @override
  List<Object> get props => [];
}

///
class LoadImages extends ItemEvent {}

///
class AddImage extends ItemEvent {}

///
class UpdateImages extends ItemEvent {
  ///
  const UpdateImages({@required this.images});

  ///
  final List<ItemModel> images;
}
