import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/tab/tab_bloc.dart';
import '../blocs/tab/tab_event.dart';
import '../models/app_tab/app_tab.dart';
import '../widgets/render_screens.dart';
import '../widgets/tab_selector.dart';

///
class HomeScreen extends StatefulWidget {
  ///
  const HomeScreen({Key key}) : super(key: key);

  ///
  static Route get route =>
      MaterialPageRoute<void>(builder: (_) => const HomeScreen());

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) => BlocBuilder<TabBloc, AppTab>(
        builder: (context, state) => Scaffold(
          body: RenderScreens(state: state),
          bottomNavigationBar: TabSelector(
              activeTab: state,
              onTabSelected: (tab) =>
                  context.read<TabBloc>().add(UpdateTab(tab: tab))),
        ),
      );
}
