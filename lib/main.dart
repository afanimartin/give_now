import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:give_now/blocs/image/image_bloc.dart';
import 'package:give_now/blocs/image/image_event.dart';
import 'package:give_now/blocs/simple_bloc_observer.dart';
import 'package:give_now/blocs/tab/tab_bloc.dart';
import 'package:give_now/repositories/authentication/authentication_repository.dart';
import 'package:give_now/repositories/image_upload/image_repository.dart';
import 'package:give_now/screens/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Bloc.observer = SimpleBlocObserver();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<TabBloc>(
        create: (_) => TabBloc(),
      ),
      BlocProvider<ImageBloc>(
          create: (_) =>
              ImageBloc(imageRepository: ImageRepository())..add(LoadImages()))
    ],
    child: App(
      authenticationRepository: AuthenticationRepository(),
    ),
  ));
}
