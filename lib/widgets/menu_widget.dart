import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/item/item_bloc.dart';
import '../blocs/item/item_event.dart';

import '../models/item/item.dart';

///
// ignore: must_be_immutable
class MenuWidget extends StatelessWidget {
  ///
  MenuWidget({@required this.item, Key key}) : super(key: key);

  ///
  final Item item;

  ///
  ItemBloc _itemBloc;

  @override
  Widget build(BuildContext context) {
    _itemBloc = BlocProvider.of<ItemBloc>(context);

    return PopupMenuButton<String>(
        itemBuilder: (context) => {'Delete', 'Donate'}
            .map((choice) =>
                PopupMenuItem<String>(value: choice, child: Text(choice)))
            .toList(),
        onSelected: (String value) {
          if (value == 'Delete') {
            _itemBloc.add(DeleteItem(item: item));

            Future.delayed(const Duration(seconds: 5));

            Navigator.of(context).pop();
          }

          _itemBloc.add(DonateItem(item: item));

          Navigator.of(context).pop();
        });
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Item>('item', item));
  }
}
