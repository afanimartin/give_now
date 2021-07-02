import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart/cart_bloc.dart';
import '../blocs/cart/cart_state.dart';
import '../models/app_tab/app_tab.dart';

///
class TabSelector extends StatelessWidget {
  ///
  const TabSelector(
      {@required this.activeTab, @required this.onTabSelected, Key key})
      : super(key: key);

  ///
  final AppTab activeTab;

  ///
  final Function(AppTab) onTabSelected;

  // ignore: avoid_field_initializers_in_const_classes
  final double _size = 30;

  @override
  Widget build(BuildContext context) => BottomNavigationBar(
      elevation: 0,
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTab.values[index]),
      backgroundColor: Theme.of(context).accentColor,
      items: AppTab.values
          .map((tab) => BottomNavigationBarItem(
              icon: _tabIcon(tab, context),
              label: _tabLabel(tab),
              backgroundColor: Theme.of(context).accentColor))
          .toList());

  Widget _tabIcon(AppTab tab, BuildContext context) {
    switch (tab) {
      case AppTab.home:
        return Icon(
          Icons.home_outlined,
          size: _size,
        );
        break;
      case AppTab.profile:
        return Icon(
          Icons.person_outline,
          size: _size,
        );
        break;
      case AppTab.cart:
        return BlocBuilder<CartBloc, CartState>(
          builder: (context, state) => Stack(children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: _size,
            ),
            if (state is CartItemsLoaded)
              state.currentUserCartItems.isNotEmpty
                  ? Positioned(
                      left: 7.5,
                      top: 13,
                      child: Container(
                        height: 10,
                        width: 15,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle),
                        child: const SizedBox.shrink(),
                      ),
                    )
                  : const SizedBox.shrink()
          ]),
        );
        break;
    }
    return const Icon(
      Icons.home_outlined,
    );
  }

  String _tabLabel(AppTab tab) {
    switch (tab) {
      case AppTab.home:
        return 'Home';
        break;
      case AppTab.profile:
        return 'Profile';
        break;
      case AppTab.cart:
        return 'Cart';
        break;
    }
    return '';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<AppTab>('activeTab', activeTab));
    // ignore: cascade_invocations
    properties.add(DiagnosticsProperty<Function(AppTab p1)>(
        'onTabSelected', onTabSelected));
  }
}
