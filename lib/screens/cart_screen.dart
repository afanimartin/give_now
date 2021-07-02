import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/cart/cart_bloc.dart';
import '../blocs/cart/cart_event.dart';
import '../blocs/cart/cart_state.dart';
import '../widgets/progress_loader.dart';

///
class CartScreen extends StatefulWidget {
  ///
  const CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Complete purchase',
          style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: 28,
              letterSpacing: 1.2),
        ),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
        if (state is CartItemsLoaded) {
          return state.currentUserCartItems.isNotEmpty
              ? SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.currentUserCartItems?.length ?? 0,
                          itemBuilder: (context, index) {
                            final item = state.currentUserCartItems[index];

                            return Card(
                              elevation: 4,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(6),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: item.mainImageUrl,
                                          height: 70,
                                          width: 70,
                                          fit: BoxFit.cover,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: Text(
                                          item.title,
                                          style: const TextStyle(
                                              fontSize: 16, letterSpacing: 0.5),
                                        )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: Text(
                                          '${item.price} SSP',
                                          style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500),
                                        )),
                                        IconButton(
                                            icon: state
                                                    is ItemBeingRemovedFromCart
                                                ? const ProgressLoader()
                                                : const Icon(
                                                    Icons.cancel_rounded),
                                            color:
                                                Theme.of(context).primaryColor,
                                            iconSize: 30,
                                            onPressed: () => context
                                                .read<CartBloc>()
                                                .add(RemoveItemFromCart(
                                                    item: item)))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                      Padding(
                        padding: const EdgeInsets.all(6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w400),
                            ),
                            Text('${state.totalCost}',
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w400))
                          ],
                        ),
                      )
                    ],
                  ))
              : const Center(
                  child: Text('No items in your cart. Shop to add'),
                );
        }

        return const ProgressLoader();
      }));
}
