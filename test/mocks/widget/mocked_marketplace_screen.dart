import 'package:flutter/material.dart';

class MockedMarketPlaceScreen extends StatefulWidget {
  const MockedMarketPlaceScreen({Key? key}) : super(key: key);

  @override
  _MockedMarketPlaceScreenState createState() =>
      _MockedMarketPlaceScreenState();
}

class _MockedMarketPlaceScreenState extends State<MockedMarketPlaceScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('moostamil'),
        ),
        floatingActionButton: FloatingActionButton(
          key: const Key('floating_action_button'),
          onPressed: () {},
        ),
      );
}
