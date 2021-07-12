import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../models/item/item.dart';

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
class UpdateItems extends ItemEvent {
  ///
  const UpdateItems({@required this.items});

  ///
  final List<Item> items;

  ///
  @override
  List<Object> get props => [items];
}

///
class UpdateItem extends ItemEvent {
  ///
  const UpdateItem({@required this.item});

  ///
  final Item item;

  ///
  @override
  List<Object> get props => [item];
}

///
class DeleteItem extends ItemEvent {
  ///
  const DeleteItem({@required this.item});

  ///
  final Item item;

  ///
  @override
  List<Object> get props => [item];
}

