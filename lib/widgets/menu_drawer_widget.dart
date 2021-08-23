import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication/authentication_bloc.dart';
import '../screens/user_profile_screen.dart';
import '../utils/constants.dart';
import 'circular_avatar_widget.dart';

///
class MenuDrawerWidget extends StatelessWidget {
  ///
  const MenuDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
              child: Column(
            children: [
              CircleAvatarWidget(
                imageUrl: user.photoUrl,
                radius: Constants.fourty,
              ),
              const SizedBox(
                height: Constants.five,
              ),
              Text(
                // ignore: unnecessary_string_interpolations
                '${user.displayName}',
                style: const TextStyle(fontSize: Constants.normalFontSize),
              ),
            ],
          )),
          ListTile(
            title: Row(
              children: const [
                Text(
                  'Current items',
                  style: TextStyle(fontSize: Constants.normalFontSize),
                ),
                SizedBox(
                  width: Constants.five,
                ),
                Icon(Icons.open_in_new)
              ],
            ),
            onTap: () => Navigator.of(context).push(MaterialPageRoute<void>(
                builder: (_) => const UserProfileScreen())),
          ),
          Expanded(
              child: Container()), // force bottom items to the lowest point
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Row(
                  children: const [
                    Text(
                      'Log out',
                      style: TextStyle(fontSize: Constants.standardFontSize),
                    ),
                    SizedBox(
                      width: Constants.five,
                    ),
                    Icon(Icons.logout)
                  ],
                ),
                onTap: () {
                  context.read<AuthenticationBloc>().add(LogOut());
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
