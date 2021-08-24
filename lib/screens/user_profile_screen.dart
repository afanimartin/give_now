import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../blocs/item/item_cubit.dart';
import '../blocs/item/item_state.dart';
import '../widgets/circular_avatar_widget.dart';
import '../widgets/progress_loader.dart';
import 'edit_item_screen.dart';

///
class UserProfileScreen extends StatelessWidget {
  ///
  const UserProfileScreen({Key? key}) : super(key: key);

  ///
  static Route get route =>
      MaterialPageRoute<void>(builder: (_) => const UserProfileScreen());

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).accentColor,
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: BlocBuilder<ItemCubit, ItemState>(
          builder: (context, state) => Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(),
                    Text(
                      'All items',
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    _buildListOfItems(context, state)
                  ],
                ),
              )));

  Widget _buildListOfItems(BuildContext context, ItemState state) {
    if (state is ItemsLoaded) {
      return state.currentUserItems.isNotEmpty
          ? ListView.builder(
              itemCount: state.currentUserItems.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = state.currentUserItems[index];

                return Card(
                  color: Theme.of(context).primaryColorLight,
                  elevation: 4,
                  child: ListTile(
                    leading: CircleAvatarWidget(
                      imageUrl: item.mainImageUrl,
                    ),
                    title: Text(item.title!),
                    trailing: Text(timeago.format(item.createdAt!.toDate())),
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<Widget>(
                            builder: (_) => EditItemScreen(item: item))),
                  ),
                );
              })
          : state is ItemBeingDonated || state is ItemBeingDeleted
              ? ProgressLoader(
                  backgroundColor: Theme.of(context).accentColor,
                )
              : const Text('You have no items to sell');
    }

    return ProgressLoader(
      backgroundColor: Theme.of(context).accentColor,
    );
  }
}
