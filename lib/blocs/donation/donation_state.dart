import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  DonationsUpdated({@required this.donations, FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  ///
  final List<ItemModel> donations;

  ///
  final FirebaseAuth _firebaseAuth;

  ///
  List<ItemModel> get currentUserDonations => donations
      .where((donation) => _firebaseAuth.currentUser.uid == donation.userId)
      .toList();

  @override
  List<Object> get props => [donations];
}
