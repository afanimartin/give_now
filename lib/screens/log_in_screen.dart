import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/login/login_cubit.dart';
import '../repositories/authentication/authentication_repository.dart';

///
class LogInScreen extends StatelessWidget {
  ///
  const LogInScreen({Key key}) : super(key: key);

  ///
  static Route<void> get route =>
      MaterialPageRoute<void>(builder: (_) => const LogInScreen());

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        body: BlocProvider<LogInCubit>(
          create: (context) =>
              LogInCubit(authenticationRepository: AuthenticationRepository()),
          child: Align(
            alignment: const Alignment(0, -1 / 3),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Image.asset(
                    'assets/givenow-logo.png',
                    height: 150,
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                _GoogleLogInButton()
              ],
            ),
          ),
        ),
      );
}

class _GoogleLogInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ElevatedButton(
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Theme.of(context).primaryColorDark)),
      onPressed: () => context.read<LogInCubit>().logIn(),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/google_logo.png',
              height: 40,
            ),
            const SizedBox(width: 4),
            Text(
              'Log in with Google',
              style: TextStyle(
                  fontSize: 26,
                  color: Theme.of(context).primaryColorLight,
                  letterSpacing: 1.2),
            )
          ],
        ),
      ));
}
