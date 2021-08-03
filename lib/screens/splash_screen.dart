import 'package:flutter/material.dart';
import '../utils/constants.dart';

///
class SplashScreen extends StatelessWidget {
  ///
  const SplashScreen({Key key}) : super(key: key);

  ///
  static Route<Widget> get route =>
      MaterialPageRoute<Widget>(builder: (_) => const SplashScreen());

  @override
  Widget build(BuildContext context) => Container(
        color: Theme.of(context).primaryColorLight,
        child: Center(
            child: Image.asset(
          'assets/moostamil.png',
          height: Constants.oneHundred,
        )),
      );
}
