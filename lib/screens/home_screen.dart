import 'package:flutter/material.dart';

import 'marketplace_screen.dart';

///
class HomeScreen extends StatelessWidget {
  ///
  const HomeScreen({Key? key}) : super(key: key);

  ///
  static Route get route =>
      MaterialPageRoute<void>(builder: (_) => const HomeScreen());
  @override
  Widget build(BuildContext context) => const Scaffold(
        body: MarketplaceScreen(),
      );
}
