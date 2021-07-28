import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/cart/cart_bloc.dart';
import '../blocs/cart/cart_event.dart';
import '../blocs/cart/cart_state.dart';
import '../models/item/item.dart';
import '../utils/constants.dart';
import '../widgets/circular_avatar_widget.dart';
import '../widgets/floating_action_button.dart';
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
            backgroundColor: Theme.of(context).accentColor,
          );
        }
        return Scaffold(
          backgroundColor: Theme.of(context).accentColor,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Complete purchase',
              style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: 28,
                  letterSpacing: Constants.onePointTwo),
            ),
            backgroundColor: Theme.of(context).accentColor,
            iconTheme: Theme.of(context).iconTheme,
          ),
          body: state is CartItemsLoaded &&
                  state.currentUserCartItems.isNotEmpty
              ? SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.currentUserCartItems?.length ?? 0,
                          itemBuilder: (context, index) {
                            final item = state.currentUserCartItems[index];

                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: Constants.eight,
                                  horizontal:
                                      MediaQuery.of(context).size.width /
                                          Constants.horizontalPadding),
                              child: Card(
                                elevation: Constants.elevation,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.all(Constants.six),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CircleAvatarWidget(
                                              imageUrl: item.mainImageUrl),
                                          const SizedBox(
                                            width: Constants.ten,
                                          ),
                                          Expanded(
                                              child: Text(
                                            item.title,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                letterSpacing:
                                                    Constants.pointFive),
                                          )),
                                          const SizedBox(
                                            width: Constants.ten,
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
                                              iconSize: Constants.thirty,
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
                        padding: EdgeInsets.symmetric(
                            vertical: Constants.eight,
                            horizontal: MediaQuery.of(context).size.width /
                                Constants.horizontalPadding),
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
            child: FloatingActionButtonWidget(
              onPressed: () => state is CartItemsLoaded &&
                      state.currentUserCartItems.isNotEmpty
                  ? _modalBottomSheet(context, state.currentUserCartItems)
                  : const SizedBox.shrink(),
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(
                Icons.check,
                size: Constants.thirty,
              ),
            ),
          ),
        );
      });

  Future<Widget> _modalBottomSheet(BuildContext context, List<Item> cartItems) {
    final _cartItems = <Map<String, dynamic>>[];

    for (var i = 0; i < cartItems.length; i++) {
      _cartItems.add(cartItems[i].toItemDocument());
    }

    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: true,
        shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(Constants.twenty))),
        builder: (context) => Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.twenty, vertical: Constants.ten),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _buyerAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor),
                            borderRadius:
                                BorderRadius.circular(Constants.five)),
                        labelText: 'address'),
                  ),
                  const SizedBox(
                    height: Constants.six,
                  ),
                  TextField(
                    controller: _buyerPhoneNumber,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor),
                            borderRadius:
                                BorderRadius.circular(Constants.five)),
                        labelText: 'phone'),
                  ),
                  const SizedBox(height: Constants.six),
                  ElevatedButton(
                      onPressed: () async {
                        if (_buyerAddress.text.isNotEmpty &&
                            _buyerPhoneNumber.text.isNotEmpty) {
                          final _sale = Item(
                              buyerAddress: _buyerAddress.text,
                              buyerPhoneNumber: _buyerPhoneNumber.text,
                              cartItems: _cartItems);

                          context
                              .read<CartBloc>()
                              .add(CheckoutItem(sale: _sale));

                          await Future<Duration>.delayed(
                              const Duration(seconds: 1));

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
