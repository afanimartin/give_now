import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedantic/pedantic.dart';
import 'package:equatable/equatable.dart';
import '../../models/user/user_model.dart';

import '../../repositories/authentication/authentication_repository.dart';

part 'authentication_state.dart';
part 'authentication_event.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  StreamSubscription _userStreamSubscription;

  AuthenticationBloc(
      {@required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unknown()) {
    _userStreamSubscription?.cancel();

    _userStreamSubscription = _authenticationRepository.user
        .listen((user) => add(AppStarted(user: user)));
  }

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield _mapAppStartedToState(event);
    } else if (event is LogOut) {
      unawaited(_authenticationRepository.logOut());
    }
  }

  AuthenticationState _mapAppStartedToState(AppStarted event) =>
      event.user == UserModel.empty
          ? const AuthenticationState.unauthenticated()
          : AuthenticationState.authenticated(event.user);
}
