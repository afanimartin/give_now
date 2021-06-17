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
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is LoadingCartItems) {
              return const ProgressLoader();
            }
            if (state is CartState) {
              return state.cartItems.isNotEmpty
                  ? SingleChildScrollView(
                      physics: const ScrollPhysics(),
                      child: Column(
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.cartItems?.length ?? 0,
                              itemBuilder: (context, index) {
                                final item = state.cartItems[index];

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
                                                  fontSize: 16,
                                                  letterSpacing: 0.5),
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
                                                icon: const Icon(
                                                    Icons.cancel_rounded),
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
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text('${state.totalCost}',
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w400))
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  : const Center(
                      child: Text('No items added to cart'),
                    );
            }

            return const ProgressLoader();
          },
        ),
      );
}
