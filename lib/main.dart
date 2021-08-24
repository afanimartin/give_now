// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/cart/cart_cubit.dart';
import 'blocs/item/item_cubit.dart';
import 'blocs/tab/tab_bloc.dart';
import 'repositories/authentication/authentication_repository.dart';
import 'repositories/cart/cart_repository.dart';
import 'repositories/item/item_repository.dart';
import 'screens/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  // final host = Platform.isAndroid ? '10.0.2.2:8080' : '127.0.0.1:8080';

  // [Firestore | localhost:8080]
  // FirebaseFirestore.instance.settings =
  //     Settings(host: host, sslEnabled: false, persistenceEnabled: false);

  // [Authentication | localhost:9099]
  // await FirebaseAuth.instance.useEmulator('http://localhost:9099');

  // [Storage | localhost:9199]
  // await FirebaseStorage.instance.useEmulator(host: host, port: 9199);

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<TabBloc>(
        create: (_) => TabBloc(),
      ),
      BlocProvider<ItemCubit>(
          create: (_) => ItemCubit(
              itemRepository: ItemRepository(),
              cartRepository: CartRepository(),
              firebaseAuth: FirebaseAuth.instance)
            ..fetchItems()),
      BlocProvider<CartCubit>(
          create: (_) => CartCubit(
              cartRepository: CartRepository(),
              uploadRepository: ItemRepository())
            ..loadCartItems()),
    ],
    child: App(
      authenticationRepository: AuthenticationRepository(),
    ),
  ));
}
