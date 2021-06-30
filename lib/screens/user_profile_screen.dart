import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication/authentication_bloc.dart';
import '../widgets/circular_avatar_widget.dart';
import 'log_in_screen.dart';

///
class UserProfileScreen extends StatelessWidget {
  ///
  const UserProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);

    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Profile',
          style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: 28,
              letterSpacing: 1.2),
        ),
        backgroundColor: Theme.of(context).accentColor,
        actions: [
          IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).primaryColorDark,
                size: 30,
              ),
              onPressed: () {
                context.read<AuthenticationBloc>().add(LogOut());

                Navigator.of(context).pushAndRemoveUntil<void>(
                    LogInScreen.route, (route) => false);
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(),
            CircleAvatarWidget(radius: 40, imageUrl: user.photoUrl),
            Text(
              user.displayName,
              style: const TextStyle(fontSize: 28),
            ),
            Text(
              user.email,
              style: const TextStyle(fontSize: 22, color: Colors.black45),
            ),
          ],
        ),
      ),
    );
  }
}
