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
  static Route route() =>
      MaterialPageRoute<void>(builder: (_) => const HomeScreen());

  @override
  Widget build(BuildContext context) => BlocBuilder<TabBloc, AppTab>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text(
              'Givenow',
              style: TextStyle(
                  color: Colors.black, fontSize: 28, letterSpacing: 1.2),
            ),
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                  icon: const Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: () {
                    context.read<AuthenticationBloc>().add(LogOut());

                    Navigator.of(context).pushAndRemoveUntil<void>(
                        LogInScreen.route(), (route) => false);
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
