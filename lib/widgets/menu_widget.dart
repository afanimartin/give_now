import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart/cart_bloc.dart';
import '../blocs/cart/cart_event.dart';

import '../blocs/item/item_cubit.dart';
import '../models/item/item.dart';
import '../screens/user_profile_screen.dart';

///
// ignore: must_be_immutable
class MenuWidget extends StatelessWidget {
  ///
  MenuWidget({required this.item, Key? key}) : super(key: key);

  ///
  final Item item;

  ///
  late ItemCubit _itemBloc;

  ///
  late CartBloc _cartBloc;

  ///
  // late DonationBloc _donationBloc;

  @override
  Widget build(BuildContext context) {
    _itemBloc = BlocProvider.of<ItemCubit>(context);

    _cartBloc = BlocProvider.of<CartBloc>(context);

    // _donationBloc = BlocProvider.of<DonationBloc>(context);

    return PopupMenuButton<String>(
        itemBuilder: (context) => {'Delete', 'Donate'}
            .map((choice) =>
                PopupMenuItem<String>(value: choice, child: Text(choice)))
            .toList(),
        onSelected: (String value) {
          if (value == 'Delete') {
            _itemBloc.deleteItem(item);

            _cartBloc.add(RemoveItemFromCart(item: item));

            Navigator.of(context).pushAndRemoveUntil<void>(
                UserProfileScreen.route, (route) => false);
          } else {
            // _donationBloc.add(DonateItem(item: item));

            Navigator.of(context).pushAndRemoveUntil<void>(
                UserProfileScreen.route, (route) => false);
          }
        });
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Item>('item', item));
  }
}
