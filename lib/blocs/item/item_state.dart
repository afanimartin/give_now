import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import '../../models/item/item.dart';

///
class ItemState extends Equatable {
  ///
  const ItemState();

  @override
  List<Object> get props => [];
}

///
class ItemUpdated extends ItemState {
  ///
  const ItemUpdated({
    @required this.items,
  });

  ///
  final List<Item> items;

  @override
  List<Object> get props => [items];
}

///
class ImagesToUploadPicked extends ItemState {
  ///
  const ImagesToUploadPicked({@required this.images});

  ///
  final List<Asset> images;

  @override
  List<Object> get props => [images];
}

///
class ItemIsBeingAdded extends ItemState {}

///
class ItemIsBeingDonated extends ItemState {}

///
class ItemIsDonatedSuccessfully extends ItemState {}
