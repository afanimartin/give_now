import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../models/item/item.dart';

///
class ItemEvent extends Equatable {
  ///
  const ItemEvent();

  ///
  @override
  List<Object> get props => [];
}

///
class PickAndPreviewImages extends ItemEvent {}

///
class UploadItem extends ItemEvent {
  ///
  const UploadItem({@required this.item});

  ///
  final Item item;

  ///
  @override
  List<Object> get props => [item];
}
