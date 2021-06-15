import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
class ItemIsBeingAdded extends ItemState {}

///
class ItemIsBeingDonated extends ItemState {}

///
class ItemIsDonatedSuccessfully extends ItemState {}
