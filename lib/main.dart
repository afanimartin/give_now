// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/cart/cart_bloc.dart';
import 'blocs/cart/cart_event.dart';
import 'blocs/donation/donation_bloc.dart';
import 'blocs/item/item_bloc.dart';
import 'blocs/item/item_event.dart';
import 'blocs/tab/tab_bloc.dart';
import 'blocs/upload/upload_bloc.dart';
import 'repositories/authentication/authentication_repository.dart';
import 'repositories/cart/cart_repository.dart';
import 'repositories/donation/donation_repository.dart';
import 'repositories/upload/upload_repository.dart';
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
      BlocProvider<ItemBloc>(
          create: (_) =>
              ItemBloc(uploadRepository: UploadRepository())..add(LoadItems())),
      BlocProvider<CartBloc>(
          create: (_) => CartBloc(
              cartRepository: CartRepository(),
              uploadRepository: UploadRepository())
            ..add(LoadCartItems())),
      BlocProvider<UploadBloc>(
          create: (_) => UploadBloc(itemRepository: UploadRepository())),
      BlocProvider<DonationBloc>(
          create: (_) => DonationBloc(donationRepository: DonationRepository()))
    ],
    child: App(
      authenticationRepository: AuthenticationRepository(),
    ),
  ));
}
