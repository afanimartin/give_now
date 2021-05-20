part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {
  final UserModel user;

  const AppStarted({@required this.user});

  @override
  List<Object> get props => [user];
}

class LogOut extends AuthenticationEvent {}
