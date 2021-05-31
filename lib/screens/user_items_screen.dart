import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/item/item_bloc.dart';
import '../blocs/item/item_state.dart';
import '../widgets/floating_action_button.dart';
import '../widgets/items_grid.dart';
import '../widgets/progress_loader.dart';

///
class UserItemsScreen extends StatefulWidget {
  ///
  const UserItemsScreen({Key key}) : super(key: key);

  @override
  _UserItemsScreenState createState() => _UserItemsScreenState();
}

class _UserItemsScreenState extends State<UserItemsScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocBuilder<ItemBloc, ItemState>(
          builder: (contex, state) {
            if (state is ItemUpdated) {
              return CustomScrollView(
                slivers: [
                  ItemsGrid(
                    items: state.currentUserItems,
                  )
                ],
              );
            }
            return const ProgressLoader();
          },
        ),
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
