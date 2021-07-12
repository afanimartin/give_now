import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/cart/cart_bloc.dart';
import '../blocs/cart/cart_event.dart';
import '../blocs/cart/cart_state.dart';
import '../models/cart/cart.dart';
import '../models/item/sale.dart';
import '../widgets/circular_avatar_widget.dart';
import '../widgets/progress_loader.dart';

///
class CartScreen extends StatefulWidget {
  ///
  const CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  ///
  final _buyerAddress = TextEditingController();

  ///
  final _buyerPhoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<CartBloc, CartState>(builder: (context, state) {
        if (state is ItemBeingRemovedFromCart) {
          return ProgressLoader(
            color: Theme.of(context).accentColor,
          );
        }
        return Scaffold(
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
          body: state is CartItemsLoaded &&
                  state.currentUserCartItems.isNotEmpty
              ? SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.currentUserCartItems?.length ?? 0,
                          itemBuilder: (context, index) {
                            final item = state.currentUserCartItems[index];

                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width / 27),
                              child: Card(
                                elevation: 4,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(6),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CircleAvatarWidget(
                                              imageUrl: item.mainImageUrl),
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
                                              color: Theme.of(context)
                                                  .primaryColor,
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
                      ),
                    ],
                  ))
              : const Center(
                  child: Text(
                    'No items in your cart. Shop to add',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
          floatingActionButton: Visibility(
            visible: state is CartItemsLoaded &&
                state.currentUserCartItems.isNotEmpty,
            child: FloatingActionButton(
              onPressed: () => state is CartItemsLoaded &&
                      state.currentUserCartItems.isNotEmpty
                  ? _modalBottomSheet(context, state.currentUserCartItems)
                  : const SizedBox.shrink(),
              child: const Icon(
                Icons.check,
                size: 30,
              ),
            ),
          ),
        );
      });

  Future<Widget> _modalBottomSheet(
      BuildContext context, List<CartItem> cartItems) {
    final _cartItems = <Map<String, dynamic>>[];

    for (var i = 0; i < cartItems.length; i++) {
      _cartItems.add(cartItems[i].toDocument());
    }

    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _buyerAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor),
                            borderRadius: BorderRadius.circular(5)),
                        labelText: 'address'),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: _buyerPhoneNumber,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor),
                            borderRadius: BorderRadius.circular(5)),
                        labelText: 'phone'),
                  ),
                  const SizedBox(height: 6),
                  ElevatedButton(
                      onPressed: () {
                        if (_buyerAddress.text.isNotEmpty &&
                            _buyerPhoneNumber.text.isNotEmpty) {
                          final _sale = Sale(
                              buyerAddress: _buyerAddress.text,
                              buyerPhone: _buyerPhoneNumber.text,
                              cartItems: _cartItems);

                          context.read<CartBloc>().add(SellItem(sale: _sale));

                          context.read<CartBloc>().deleteCartItems(cartItems);

                          Navigator.of(context).pop();
                        }
                      },
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(const Size(400, 50)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).primaryColor),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(16))),
                      child: const Text(
                        'Checkout',
                        style: TextStyle(fontSize: 20),
                      ))
                ],
              ),
            ));
  }

  @override
  void dispose() {
    super.dispose();

    _buyerAddress.clear();
    _buyerPhoneNumber.clear();
  }
}
