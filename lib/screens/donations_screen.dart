import 'package:flutter/material.dart';

///
class DonationsScreen extends StatefulWidget {
  ///
  const DonationsScreen({Key key}) : super(key: key);

  @override
  _DonationsScreenState createState() => _DonationsScreenState();
}

class _DonationsScreenState extends State<DonationsScreen> {
  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(
          child: Text('No donations made yet'),
        ),
      );
}
