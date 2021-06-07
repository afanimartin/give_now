import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../models/item/item_model.dart';

///
class ItemEvent extends Equatable {
  ///
  const ItemEvent();

  @override
  List<Object> get props => [];
}

///
class LoadItems extends ItemEvent {}

///
class PickAndUploadItems extends ItemEvent {}

/// 
class DonateItem extends ItemEvent {}

///
class UpdateItems extends ItemEvent {
  ///
  const UpdateItems({@required this.items});

  ///
  final List<ItemModel> items;
}
