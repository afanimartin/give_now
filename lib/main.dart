import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:give_now/repositories/authentication/authentication_repository.dart';
import 'package:give_now/screens/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(App(
    authenticationRepository: AuthenticationRepository(),
  ));
}
