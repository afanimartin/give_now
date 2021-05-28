import 'package:flutter/material.dart';
import 'package:give_now/models/app_tab/app_tab.dart';
import 'package:give_now/screens/donations_screen.dart';
import 'package:give_now/screens/user_images_screen.dart';
import 'package:give_now/screens/user_profile_screen.dart';

///
class RenderScreens extends StatelessWidget {
  ///
  const RenderScreens({@required this.state, Key key}) : super(key: key);

  ///
  final AppTab state;

  @override
  Widget build(BuildContext context) => _renderScreens(state);

  Widget _renderScreens(AppTab state) {
    switch (state) {
      case AppTab.home:
        return const UserImagesScreen();
        break;
      case AppTab.profile:
        return const UserProfileScreen();
        break;

      case AppTab.donations:
        return const DonationsScreen();
        break;

      default:
        break;
    }
    return const SizedBox.shrink();
  }
}
