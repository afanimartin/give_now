import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication/authentication_bloc.dart';
import '../widgets/circular_avatar_widget.dart';

///
class UserProfileScreen extends StatelessWidget {
  ///
  const UserProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);

    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
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
