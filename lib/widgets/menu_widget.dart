import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart/cart_cubit.dart';

import '../blocs/item/item_cubit.dart';
import '../models/item/item.dart';

///
// ignore: must_be_immutable
class MenuWidget extends StatelessWidget {
  ///
  MenuWidget({required this.item, Key? key}) : super(key: key);

  ///
  final Item item;

  ///
  late ItemCubit itemCubit;

  ///
  late CartCubit cartCubit;

  @override
  Widget build(BuildContext context) {
    itemCubit = BlocProvider.of<ItemCubit>(context);

    cartCubit = BlocProvider.of<CartCubit>(context);

    return PopupMenuButton<String>(
        itemBuilder: (context) => {'Delete', 'Donate'}
            .map((choice) =>
                PopupMenuItem<String>(value: choice, child: Text(choice)))
            .toList(),
        onSelected: (String value) {
          if (value == 'Delete') {
            itemCubit.deleteItem(item);

            cartCubit.removeItemFromCart(item);

            Navigator.of(context).pop();
          } else {
            itemCubit.donateItem(item);

            Navigator.of(context).pop();
          }
        });
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Item>('item', item));
    // ignore: cascade_invocations
    properties.add(DiagnosticsProperty<ItemCubit>('itemBloc', itemCubit));
    // ignore: cascade_invocations
    properties.add(DiagnosticsProperty<CartCubit>('cartCubit', cartCubit));
  }
}
