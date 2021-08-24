import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart/cart_cubit.dart';

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
  late ItemCubit itemBloc;

  ///
  late CartCubit cartCubit;

  ///
  // late DonationBloc donationBloc;

  @override
  Widget build(BuildContext context) {
    itemBloc = BlocProvider.of<ItemCubit>(context);

    cartCubit = BlocProvider.of<CartCubit>(context);

    // _donationBloc = BlocProvider.of<DonationBloc>(context);

    return PopupMenuButton<String>(
        itemBuilder: (context) => {'Delete', 'Donate'}
            .map((choice) =>
                PopupMenuItem<String>(value: choice, child: Text(choice)))
            .toList(),
        onSelected: (String value) {
          if (value == 'Delete') {
            itemBloc.deleteItem(item);

            cartCubit.removeItemFromCart(item);

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
    // ignore: cascade_invocations
    properties.add(DiagnosticsProperty<ItemCubit>('itemBloc', itemBloc));
    // ignore: cascade_invocations
    properties.add(DiagnosticsProperty<CartCubit>('cartCubit', cartCubit));
  }
}
