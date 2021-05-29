import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../models/image/item_model.dart';

///
class DonationState extends Equatable {
  ///
  const DonationState();

  @override
  List<Object> get props => [];
}

///
class DonationsUpdated extends DonationState {
  ///
  const DonationsUpdated({@required this.donations});

  ///
  final List<ItemModel> donations;

  @override
  List<Object> get props => [donations];
}
