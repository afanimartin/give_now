import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/item/item_bloc.dart';
import 'blocs/item/item_event.dart';
import 'blocs/simple_bloc_observer.dart';
import 'blocs/tab/tab_bloc.dart';
import 'repositories/authentication/authentication_repository.dart';
import 'repositories/image_upload/item_repository.dart';
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
              ItemBloc(imageRepository: ItemRepository())..add(LoadImages()))
    ],
    child: App(
      authenticationRepository: AuthenticationRepository(),
    ),
  ));
}
