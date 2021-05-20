import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/authentication/authentication_repository.dart';
import 'login_state.dart';

class LogInCubit extends Cubit<LogInState> {
  final AuthenticationRepository _authenticationRepository;

  LogInCubit({@required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(LogInState());

  void logIn() {
    _authenticationRepository.logInWithGoogleAccount();
  }
}
