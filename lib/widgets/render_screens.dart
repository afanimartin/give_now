import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/app_tab/app_tab.dart';
import '../screens/cart_screen.dart';
import '../screens/marketplace_screen.dart';
import '../screens/user_profile_screen.dart';

///
class RenderScreens extends StatelessWidget {
  ///
  const RenderScreens({required this.state, Key? key}) : super(key: key);

  ///
  final AppTab state;

  @override
  Widget build(BuildContext context) => _renderScreens(state);

  Widget _renderScreens(AppTab state) {
    switch (state) {
      case AppTab.home:
        return const MarketplaceScreen();
      case AppTab.profile:
        return const UserProfileScreen();
      case AppTab.cart:
        return const CartScreen();
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<AppTab>('state', state));
  }
}
