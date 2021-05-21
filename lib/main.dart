import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:give_now/blocs/image/image_cubit.dart';
import 'package:give_now/blocs/tab/tab_bloc.dart';
import 'package:give_now/repositories/authentication/authentication_repository.dart';
import 'package:give_now/repositories/image_upload/image_repository.dart';
import 'package:give_now/screens/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<TabBloc>(
        create: (_) => TabBloc(),
      ),
      BlocProvider<ImageCubit>(
          create: (_) =>
              ImageCubit(imageUploadRepository: ImageRepository()))
    ],
    child: App(
      authenticationRepository: AuthenticationRepository(),
    ),
  ));
}
