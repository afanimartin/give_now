import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/item/item.dart';

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
  DonationsUpdated({required this.donations, FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  ///
  final List<Item> donations;

  ///
  final FirebaseAuth _firebaseAuth;

  ///
  List<Item> get currentUserDonations => donations
      .where((donation) => _firebaseAuth.currentUser!.uid == donation.sellerId)
      .toList();

  @override
  List<Object> get props => [donations];
}
