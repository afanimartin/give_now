import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

import '../../models/form/item_form.dart';
import '../../models/item/item.dart';

///
class ItemState extends Equatable {
  ///
  const ItemState(
      {this.title = const ItemForm.pure(),
      this.description = const ItemForm.pure(),
      this.formzStatus = FormzStatus.pure});

  ///
  final ItemForm title;

  ///
  final ItemForm description;

  ///
  final FormzStatus formzStatus;

  @override
  List<Object> get props => [title, description, formzStatus];

  ///
  ItemState copyWith(
          {ItemForm title, ItemForm description, FormzStatus formzStatus}) =>
      ItemState(
          title: title ?? this.title,
          description: description ?? this.description,
          formzStatus: formzStatus ?? this.formzStatus);
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
