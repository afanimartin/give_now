import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) => BottomNavigationBar(
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTab.values[index]),
      backgroundColor: Colors.white,
      items: AppTab.values
          .map((tab) => BottomNavigationBarItem(
              icon: _tabIcon(tab),
              label: _tabLabel(tab),
              backgroundColor: Colors.greenAccent))
          .toList());

  Icon _tabIcon(AppTab tab) {
    switch (tab) {
      case AppTab.home:
        return const Icon(
          Icons.show_chart,
        );
        break;
      case AppTab.profile:
        return const Icon(
          Icons.person_outline,
        );
        break;
      case AppTab.marketplace:
        return const Icon(Icons.shopping_bag_outlined);
        break;
    }
    return const Icon(
      Icons.show_chart,
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
      case AppTab.marketplace:
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
