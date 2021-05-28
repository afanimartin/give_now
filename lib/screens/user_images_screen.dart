import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/item/item_bloc.dart';
import '../blocs/item/item_state.dart';
import '../widgets/floating_action_button.dart';
import '../widgets/render_images.dart';

///
class UserImagesScreen extends StatefulWidget {
  ///
  const UserImagesScreen({Key key}) : super(key: key);

  @override
  _UserImagesScreenState createState() => _UserImagesScreenState();
}

class _UserImagesScreenState extends State<UserImagesScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: const RenderImages(),
        floatingActionButton: BlocBuilder<ItemBloc, ItemState>(
            builder: (context, state) => FloatingActionButtonWidget(
                  onPressed: () =>
                      context.read<ItemBloc>().pickAnUploadImages(),
                  backgroundColor: Theme.of(context).primaryColor,
                  child: const Icon(
                    Icons.add,
                  ),
                )),
      );
}
