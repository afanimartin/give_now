import 'dart:io';

import 'package:flutter/material.dart';
import 'package:give_now/blocs/authentication/authentication_bloc.dart';
import 'package:give_now/blocs/image/image_bloc.dart';
import 'package:give_now/blocs/image/image_state.dart';
import 'package:give_now/blocs/tab/tab_bloc.dart';
import 'package:give_now/blocs/tab/tab_event.dart';
import 'package:give_now/models/app_tab/app_tab.dart';
import 'package:give_now/screens/log_in_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:give_now/widgets/render_images.dart';
import 'package:give_now/widgets/tab_selector.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  static Route route() => MaterialPageRoute(builder: (_) => const HomeScreen());

  @override
  Widget build(BuildContext context) => BlocBuilder<TabBloc, AppTab>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text(
              'Givenow',
              style: TextStyle(
                  color: Colors.black, fontSize: 28, letterSpacing: 1.2),
            ),
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: () {
                    context.read<AuthenticationBloc>().add(LogOut());
                    Navigator.of(context).pushAndRemoveUntil(
                        LogInScreen.route(), (route) => false);
                  })
            ],
          ),
          body: const RenderImages(),
          floatingActionButton: BlocBuilder<ImageBloc, ImageState>(
            builder: (context, state) {
              return FloatingActionButton(
                onPressed: () => context.read<ImageBloc>().uploadImages(),
                child: Icon(
                  Icons.add,
                ),
                backgroundColor: Colors.brown[600],
              );
            },
          ),
          bottomNavigationBar: TabSelector(
              activeTab: state,
              onTabSelected: (tab) =>
                  context.read<TabBloc>().add(UpdateTab(tab: tab))),
        ),
      );

  Future<void> _pickImages() async {
    List files = [];
    List<Asset> images = [];

    try {
      images = await MultiImagePicker.pickImages(
          maxImages: 4, selectedAssets: images);

      for (var i = 0; i < images.length; i++) {
        final path = File(images[i].identifier);
        files.add(path);
      }
      print(files);
    } on Exception catch (err) {
      print(err);
    }
  }
}
