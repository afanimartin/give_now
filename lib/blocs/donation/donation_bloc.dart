import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helpers/bloc/current_user_id.dart';
import '../../repositories/authentication/authentication_repository.dart';
import '../../repositories/item/item_repository.dart';
import '../authentication/authentication_bloc.dart';
import 'donation_event.dart';
import 'donation_state.dart';

///
class DonationBloc extends Bloc<DonationEvent, DonationState> {
  ///
  DonationBloc({@required ItemRepository itemRepository})
      : _itemRepository = itemRepository,
        super(const DonationState());

  ///
  final ItemRepository _itemRepository;

  ///
  StreamSubscription _userDonationsStreamSubscription;

  final _currentUserId = CurrentUserId(
      authenticationBloc: AuthenticationBloc(
          authenticationRepository: AuthenticationRepository()));

  @override
  Stream<DonationState> mapEventToState(DonationEvent event) async* {
    if (event is LoadDonations) {
      yield* _mapLoadDonationsToState();
    } else if (event is UpdateDonations) {
      yield* _mapDonationsUpdatedToState(event);
    }
  }

  Stream<DonationState> _mapLoadDonationsToState() async* {
    try {
      await _userDonationsStreamSubscription?.cancel();

      _userDonationsStreamSubscription = _itemRepository
          .currentUserDonations(_currentUserId.getCurrentUserId())
          .listen((donations) => add(UpdateDonations(donations: donations)));
    } on Exception catch (_) {}
  }

  Stream<DonationState> _mapDonationsUpdatedToState(
      UpdateDonations event) async* {
    yield DonationsUpdated(donations: event.donations);
  }
}
