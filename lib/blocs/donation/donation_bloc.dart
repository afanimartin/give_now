import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/donation/donation_repository.dart';
import 'donation_event.dart';
import 'donation_state.dart';

///
class DonationBloc extends Bloc<DonationEvent, DonationState> {
  ///
  DonationBloc({@required DonationRepository donationRepository})
      : _donationRepository = donationRepository,
        super(const DonationState());

  ///
  final DonationRepository _donationRepository;

  @override
  Stream<DonationState> mapEventToState(DonationEvent event) async* {
    if (event is DonateItem) {
      yield* _mapDonationsUpdatedToState(event);
    }
  }

  Stream<DonationState> _mapDonationsUpdatedToState(DonateItem event) async* {
    try {
      await _donationRepository.donate(event.item);
    } on Exception catch (_) {}
  }
}
