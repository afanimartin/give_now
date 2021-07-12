import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import '../../blocs/authentication/authentication_bloc.dart';

///
class CurrentUserId extends Equatable {
  ///
  const CurrentUserId({@required AuthenticationBloc authenticationBloc})
      : _authenticationBloc = authenticationBloc;
  final AuthenticationBloc _authenticationBloc;

  ///
  String getCurrentUserId() {
    final authState = _authenticationBloc.state;

    String currentUserId;

    if (authState is AuthenticationState) {
      currentUserId = authState.user.userId;
    }
    return currentUserId;
  }

  @override
  List<Object> get props => [];
}
