import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../blocs/authentication/authentication_bloc.dart';
import '../blocs/item/item_bloc.dart';
import '../blocs/item/item_state.dart';
import '../blocs/upload/upload_state.dart';
import '../widgets/circular_avatar_widget.dart';
import '../widgets/progress_loader.dart';
import 'edit_item_screen.dart';
import 'log_in_screen.dart';

///
class UserProfileScreen extends StatelessWidget {
  ///
  const UserProfileScreen({Key key}) : super(key: key);

  ///
  static Route get route =>
      MaterialPageRoute(builder: (_) => const UserProfileScreen());

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);

    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Profile',
          style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: 28,
              letterSpacing: 1.2),
        ),
        backgroundColor: Theme.of(context).accentColor,
        actions: [
          IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).primaryColorDark,
                size: 30,
              ),
              onPressed: () {
                context.read<AuthenticationBloc>().add(LogOut());

                Navigator.of(context).pushAndRemoveUntil<void>(
                    LogInScreen.route, (route) => false);
              })
        ],
      ),
      body: BlocBuilder<ItemBloc, ItemState>(
        builder: (context, state) => Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(),
              CircleAvatarWidget(radius: 40, imageUrl: user.photoUrl ?? ''),
              Text(
                user.displayName,
                style: const TextStyle(fontSize: 28),
              ),
              Text(
                user.email,
                style: const TextStyle(fontSize: 22, color: Colors.black45),
              ),
              const SizedBox(
                height: 8,
              ),
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
        ),
      ),
    );
  }

  Widget _buildListOfItems(BuildContext context, ItemState state) {
    if (state is ItemBeingDonated) {
      return const ProgressLoader();
    }

    if (state is ItemsLoaded) {
      return state.currentUserItems.isNotEmpty
          ? ListView.builder(
              itemCount: state.currentUserItems.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = state.currentUserItems[index];

                return Card(
                  color: Theme.of(context).accentColor,
                  elevation: 4,
                  child: ListTile(
                    leading: CircleAvatarWidget(
                      imageUrl: item.mainImageUrl,
                    ),
                    title: Text(item.title),
                    trailing: Text(timeago.format(item.createdAt.toDate())),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => EditItemScreen(item: item))),
                  ),
                );
              })
          : state is ItemIsBeingAdded || state is ItemBeingDonated
              ? const ProgressLoader()
              : const Text('You have no items to sell');
    }

    return const ProgressLoader();
  }
}
