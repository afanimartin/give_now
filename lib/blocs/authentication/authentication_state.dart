part of 'authentication_bloc.dart';

enum AuthenticationStatus { authenticated, unauthenticated }

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final UserModel user;

  const AuthenticationState._(
      {this.status = AuthenticationStatus.unauthenticated,
      this.user = UserModel.empty});

  const AuthenticationState.authenticated(UserModel user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  @override
  List<Object> get props => [status, user];
}
