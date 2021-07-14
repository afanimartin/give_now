import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/user/user.dart';

import '../../repositories/authentication/authentication_repository.dart';

part 'authentication_state.dart';
part 'authentication_event.dart';

/// Authentication bloc
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  /// Constructor
  AuthenticationBloc(
      {@required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unauthenticated()) {
    _userStreamSubscription?.cancel();

    _userStreamSubscription = _authenticationRepository.user
        .listen((user) => add(AppStarted(user: user)));
  }

  final AuthenticationRepository _authenticationRepository;
  StreamSubscription _userStreamSubscription;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield _mapAppStartedToState(event);
    } else if (event is LogOut) {
      // unawaited(_authenticationRepository.logOut());
      yield* _mapLogoutToState();
    }
  }

  AuthenticationState _mapAppStartedToState(AppStarted event) =>
      event.user == UserModel.empty
          ? const AuthenticationState.unauthenticated()
          : AuthenticationState.authenticated(event.user);

  Stream<AuthenticationState> _mapLogoutToState() async* {
    try {
      await _authenticationRepository.logOut();

      // yield* _mapAppStartedToState(event);
    } on Exception catch (_) {}
  }
}
