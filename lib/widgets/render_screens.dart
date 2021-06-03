import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/app_tab/app_tab.dart';
import '../screens/donations_screen.dart';
import '../screens/user_items_screen.dart';
import '../screens/user_profile_screen.dart';

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
        return const UserItemsScreen();
        break;
      case AppTab.profile:
        return const UserProfileScreen();
        break;

      case AppTab.donations:
        return const DonationsScreen();
        break;
    }
    return const SizedBox.shrink();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<AppTab>('state', state));
  }
}
