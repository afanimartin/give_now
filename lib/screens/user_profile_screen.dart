import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:give_now/blocs/authentication/authentication_bloc.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(),
            CircleAvatar(
                radius: 40.0,
                backgroundImage: CachedNetworkImageProvider(user.photoUrl)),
            Text(
              user.displayName,
              style: TextStyle(fontSize: 28),
            ),
            Text(
              user.email,
              style: TextStyle(fontSize: 22, color: Colors.black45),
            ),
          ],
        ),
      ),
    );
  }
}
