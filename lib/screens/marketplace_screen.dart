import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/item/item_bloc.dart';
import '../blocs/item/item_event.dart';
import '../blocs/item/item_state.dart';
import '../widgets/floating_action_button.dart';
import '../widgets/items_grid.dart';
import '../widgets/progress_loader.dart';

///
class MarketplaceScreen extends StatefulWidget {
  ///
  const MarketplaceScreen({Key key}) : super(key: key);

  @override
  _MarketplaceScreenState createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocBuilder<ItemBloc, ItemState>(
          builder: (context, state) {
            if (state is ItemUpdated) {
              return state.currentUserItems.isNotEmpty
                  ? CustomScrollView(
                      slivers: [ItemsGrid(items: state.currentUserItems)],
                    )
                  : const ProgressLoader();
            }

            return const Center(
              child: Text('No items for sale right now. Check again later.'),
            );
          },
        ),
        floatingActionButton: BlocBuilder<ItemBloc, ItemState>(
            builder: (context, state) => FloatingActionButtonWidget(
                  onPressed: () =>
                      context.read<ItemBloc>().add(PickAndUploadItems()),
                  backgroundColor: Theme.of(context).primaryColor,
                  child: state is ItemIsBeingAdded
                      ? const ProgressLoader()
                      : const Icon(
                          Icons.add,
                        ),
                )),
      );
}
