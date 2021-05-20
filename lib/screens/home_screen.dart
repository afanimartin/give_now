import 'package:flutter/material.dart';
import 'package:give_now/blocs/authentication/authentication_bloc.dart';
import 'package:give_now/screens/log_in_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  static Route route() => MaterialPageRoute(builder: (_) => const HomeScreen());

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Givenow',
            style: TextStyle(
                color: Colors.black, fontSize: 28, letterSpacing: 1.2),
          ),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
                icon: Icon(
                  Icons.exit_to_app,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  context.read<AuthenticationBloc>().add(LogOut());
                  Navigator.of(context).pushAndRemoveUntil(
                      LogInScreen.route(), (route) => false);
                })
          ],
        ),
      );
}
