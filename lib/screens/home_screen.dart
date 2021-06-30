import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication/authentication_bloc.dart';
import '../blocs/tab/tab_bloc.dart';
import '../blocs/tab/tab_event.dart';
import '../models/app_tab/app_tab.dart';
import '../widgets/render_screens.dart';
import '../widgets/tab_selector.dart';
import 'log_in_screen.dart';

///
class HomeScreen extends StatelessWidget {
  ///
  const HomeScreen({Key key}) : super(key: key);

  ///
  static Route get route =>
      MaterialPageRoute<void>(builder: (_) => const HomeScreen());

  @override
  Widget build(BuildContext context) => BlocBuilder<TabBloc, AppTab>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              'Dalala',
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
          body: RenderScreens(state: state),
          bottomNavigationBar: TabSelector(
              activeTab: state,
              onTabSelected: (tab) =>
                  context.read<TabBloc>().add(UpdateTab(tab: tab))),
        ),
      );
}
