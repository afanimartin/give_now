import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:give_now/blocs/cart/cart_bloc.dart';
import 'package:give_now/blocs/cart/cart_event.dart';

import 'blocs/donation/donation_bloc.dart';
import 'blocs/donation/donation_event.dart';
import 'blocs/item/item_bloc.dart';
import 'blocs/item/item_event.dart';
import 'blocs/simple_bloc_observer.dart';
import 'blocs/tab/tab_bloc.dart';
import 'repositories/authentication/authentication_repository.dart';
import 'repositories/item/item_repository.dart';
import 'screens/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Bloc.observer = SimpleBlocObserver();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<TabBloc>(
        create: (_) => TabBloc(),
      ),
      BlocProvider<ItemBloc>(
          create: (_) =>
              ItemBloc(itemRepository: ItemRepository())..add(LoadItems())),
      BlocProvider<DonationBloc>(
          create: (_) => DonationBloc(itemRepository: ItemRepository())
            ..add(LoadDonations())),
      BlocProvider<CartBloc>(create: (_) => CartBloc()..add(LoadCartItems())),
    ],
    child: App(
      authenticationRepository: AuthenticationRepository(),
    ),
  ));
}
