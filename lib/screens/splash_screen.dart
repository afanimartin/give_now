import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  static Route<Widget> route() =>
      MaterialPageRoute<Widget>(builder: (_) => const SplashScreen());

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        child: Center(
            child: Image.asset(
          'assets/skanner-logo.png',
          height: 100,
        )),
      );
}
