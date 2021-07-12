import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication/authentication_bloc.dart';
import '../repositories/authentication/authentication_repository.dart';
import '../utils/app_theme.dart';
import 'home_screen.dart';
import 'log_in_screen.dart';
import 'splash_screen.dart';

///
class App extends StatelessWidget {
  ///
  const App({
    @required this.authenticationRepository,
    Key key,
  }) : super(key: key);

  ///
  final AuthenticationRepository authenticationRepository;

  @override
  Widget build(BuildContext context) => RepositoryProvider.value(
        value: authenticationRepository,
        child: BlocProvider<AuthenticationBloc>(
          create: (_) => AuthenticationBloc(
            authenticationRepository: authenticationRepository,
          ),
          child: const AppView(),
        ),
      );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<AuthenticationRepository>(
        'authenticationRepository', authenticationRepository));
  }
}

///
class AppView extends StatefulWidget {
  ///
  const AppView({Key key}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: _navigatorKey,
        theme: appTheme(),
        builder: (context, child) =>
            BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomeScreen.route,
                  (route) => false,
                );
                break;

              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LogInScreen.route,
                  (route) => false,
                );
                break;
            }
          },
          child: child,
        ),
        onGenerateRoute: (_) => SplashScreen.route,
      );
}
