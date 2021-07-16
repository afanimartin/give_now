import 'package:flutter/material.dart';


///
class CompleteProfileScreen extends StatelessWidget {
  ///
  const CompleteProfileScreen({Key key}) : super(key: key);

  ///
  static Route get route =>
      MaterialPageRoute<Widget>(builder: (_) => const CompleteProfileScreen());

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          'Complete your profile',
          style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              letterSpacing: 1.2,
              height: 0.8),
        ),
      ),
    );
}
