part of 'authentication_bloc.dart';

/// AuthenticationEvent base class
abstract class AuthenticationEvent extends Equatable {
  /// AuthenticationEvent constructor
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

/// AppStarted
class AppStarted extends AuthenticationEvent {
  /// AppStarted constructor
  const AppStarted({@required this.user});

  ///
  final UserModel user;

  @override
  List<Object> get props => [user];
}

///
class LogOut extends AuthenticationEvent {}
