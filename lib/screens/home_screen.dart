import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moostamil/screens/marketplace_screen.dart';

import '../blocs/tab/tab_bloc.dart';
import '../models/app_tab/app_tab.dart';
import '../widgets/render_screens.dart';

///
class HomeScreen extends StatefulWidget {
  ///
  const HomeScreen({Key? key}) : super(key: key);

  ///
  static Route get route =>
      MaterialPageRoute<void>(builder: (_) => const HomeScreen());

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: MarketplaceScreen());
}
