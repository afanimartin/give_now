import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/item/item_cubit.dart';
import '../blocs/item/item_state.dart';
import '../utils/constants.dart';
import '../widgets/floating_action_button.dart';
import '../widgets/items_grid.dart';
import 'item_preview_screen.dart';

///
class MarketplaceScreen extends StatefulWidget {
  ///
  const MarketplaceScreen({Key? key}) : super(key: key);

  ///
  static Route get route =>
      MaterialPageRoute<Widget>(builder: (_) => const MarketplaceScreen());

  @override
  _MarketplaceScreenState createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  @override
  Widget build(BuildContext context) => BlocBuilder<ItemBloc, ItemState>(
        builder: (context, state) => Scaffold(
            backgroundColor: Theme.of(context).accentColor,
            appBar: AppBar(
              title: Text(
                'Dalala',
                style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: 28,
                    letterSpacing: Constants.onePointTwo),
              ),
              backgroundColor: Theme.of(context).accentColor,
              actions: [
                IconButton(
                    icon: Icon(
                      Icons.brightness_6_outlined,
                      size: Constants.thirty,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {})
              ],
            ),
            body: state is ItemsLoaded && state.itemsForSale.isNotEmpty
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: Constants.eight),
                    child: CustomScrollView(
                      slivers: [ItemsGrid(items: state.itemsForSale)],
                    ),
                  )
                : const Center(
                    child: Text(
                      'No items for sale right now. Check again later.',
                      style: TextStyle(fontSize: Constants.twenty),
                    ),
                  ),
            floatingActionButton: Visibility(
              visible: state is! ItemBeingAdded,
              child: FloatingActionButtonWidget(
                onPressed: () {
                  context.read<ItemBloc>().addImagesToState();

                  Navigator.of(context).push(MaterialPageRoute<Widget>(
                      builder: (_) => const ItemPreviewScreen()));
                },
                backgroundColor: Theme.of(context).primaryColor,
                child: const Icon(
                  Icons.add,
                ),
              ),
            )),
      );
}
