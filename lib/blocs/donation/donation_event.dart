import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../models/item/item.dart';

///
class DonationEvent extends Equatable {
  ///
  const DonationEvent();

  @override
  List<Object> get props => [];
}

///
class LoadDonations extends DonationEvent {}

///
class UpdateDonations extends DonationEvent {
  ///
  const UpdateDonations({@required this.donations});

  ///
  final List<Item> donations;

  @override
  List<Object> get props => [donations];
}
