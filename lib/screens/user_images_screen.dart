import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:give_now/blocs/image/image_bloc.dart';
import 'package:give_now/blocs/image/image_state.dart';
import 'package:give_now/widgets/floating_action_button.dart';
import 'package:give_now/widgets/render_images.dart';

class UserImagesScreen extends StatefulWidget {
  const UserImagesScreen({Key key}) : super(key: key);

  @override
  _UserImagesScreenState createState() => _UserImagesScreenState();
}

class _UserImagesScreenState extends State<UserImagesScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: const RenderImages(),
        floatingActionButton: BlocBuilder<ImageBloc, ImageState>(
          builder: (context, state) {
            return FloatingActionButtonWidget(
              onPressed: () => context.read<ImageBloc>().pickAnUploadImages(),
              child: Icon(
                Icons.add,
              ),
              backgroundColor: Theme.of(context).primaryColor,
            );
          },
        ),
      );
}
