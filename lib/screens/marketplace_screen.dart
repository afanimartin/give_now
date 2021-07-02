import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/item/item_bloc.dart';
import '../blocs/item/item_state.dart';
import '../blocs/upload/upload_bloc.dart';
import '../blocs/upload/upload_event.dart';
import '../blocs/upload/upload_state.dart';
import '../widgets/floating_action_button.dart';
import '../widgets/items_grid.dart';
import '../widgets/progress_loader.dart';
import 'item_preview_screen.dart';

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
        backgroundColor: Theme.of(context).accentColor,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Dalala',
            style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontSize: 28,
                letterSpacing: 1.2),
          ),
          backgroundColor: Theme.of(context).accentColor,
          actions: [
            IconButton(
                icon: Icon(
                  Icons.brightness_6_outlined,
                  size: 30,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {})
          ],
        ),
        body: BlocBuilder<ItemBloc, ItemState>(
          builder: (context, state) {
            if (state is ItemsLoaded) {
              return state.itemsForSale.isNotEmpty
                  ? CustomScrollView(
                      slivers: [ItemsGrid(items: state.itemsForSale)],
                    )
                  : const Center(
                      child: Text(
                          'No items for sale right now. Check again later.'),
                    );
            }

            return const ProgressLoader();
          },
        ),
        floatingActionButton: BlocBuilder<UploadBloc, UploadState>(
            builder: (context, state) => FloatingActionButtonWidget(
                  onPressed: () {
                    context.read<UploadBloc>().add(PickAndPreviewImages());

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const ItemPreviewScreen()));
                  },
                  backgroundColor: Theme.of(context).primaryColor,
                  child: state is ItemIsBeingAdded
                      ? const ProgressLoader()
                      : const Icon(
                          Icons.add,
                        ),
                )),
      );
}
