import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../blocs/login/login_cubit.dart';
import '../repositories/authentication/authentication_repository.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key key}) : super(key: key);

  static Route<void> route() =>
      MaterialPageRoute<void>(builder: (_) => const LogInScreen());

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: BlocProvider(
          create: (context) =>
              LogInCubit(authenticationRepository: AuthenticationRepository()),
          child: Align(
            alignment: const Alignment(0, -1 / 3),
            child: Column(
              children: [
                Image.asset(
                  'assets/givenow-logo.png',
                  height: 150,
                ),
                const SizedBox(
                  height: 100,
                ),
                const SizedBox(
                  height: 6,
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
      style:
          ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black)),
      onPressed: () => context.read<LogInCubit>().logIn(),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              FontAwesomeIcons.google,
              size: 28,
            ),
            SizedBox(width: 4),
            Text(
              'Log in with Google',
              style: TextStyle(fontSize: 22),
            )
          ],
        ),
      ));
}
