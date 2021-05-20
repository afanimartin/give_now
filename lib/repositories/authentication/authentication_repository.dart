import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../models/user_model.dart';
import 'i_authentication_repository.dart';

class AuthenticationRepository extends IAuthenticationRepository {
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _firebaseAuth;

  AuthenticationRepository(
      {GoogleSignIn googleSignIn, FirebaseAuth firebaseAuth})
      : _googleSignIn = googleSignIn ?? GoogleSignIn.standard(),
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Stream<UserModel> get user =>
      _firebaseAuth.authStateChanges().map((firebaseUser) =>
          firebaseUser == null ? UserModel.empty : toUser(firebaseUser));

  @override
  Future<void> logInWithGoogleAccount() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser.authentication;

      final googleCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      await _firebaseAuth.signInWithCredential(googleCredential);
    } on Exception catch (_) {}
  }

  @override
  Future<UserModel> getCurrentUser() async {
    final currentUser = _firebaseAuth.currentUser;

    if (currentUser == null) {
      return null;
    }

    return toUser(currentUser);
  }

  @override
  Future<void> logOut() async {
    try {
      await Future.wait([_googleSignIn.signOut()]);
    } on Exception catch (_) {}
  }

  UserModel toUser(User firebaseUser) => UserModel(
      id: firebaseUser.uid,
      email: firebaseUser.email,
      displayName: firebaseUser.displayName,
      photoUrl: firebaseUser.photoURL);
}
