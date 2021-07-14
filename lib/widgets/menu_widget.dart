import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:give_now/screens/user_profile_screen.dart';
import '../blocs/donation/donation_bloc.dart';
import '../blocs/donation/donation_event.dart';
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

  ///
  DonationBloc _donationBloc;

  @override
  Widget build(BuildContext context) {
    _itemBloc = BlocProvider.of<ItemBloc>(context);
    _donationBloc = BlocProvider.of<DonationBloc>(context);

    return PopupMenuButton<String>(
        itemBuilder: (context) => {'Delete', 'Donate'}
            .map((choice) =>
                PopupMenuItem<String>(value: choice, child: Text(choice)))
            .toList(),
        onSelected: (String value) {
          if (value == 'Delete') {
            _itemBloc.add(DeleteItem(item: item));

            Navigator.of(context)
                .pushAndRemoveUntil(UserProfileScreen.route, (route) => false);
          } else {
            _donationBloc.add(DonateItem(item: item));

            Navigator.of(context)
                .pushAndRemoveUntil(UserProfileScreen.route, (route) => false);
          }
        });
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Item>('item', item));
  }
}
