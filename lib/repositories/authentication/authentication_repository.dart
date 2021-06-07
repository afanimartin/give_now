import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../models/user/user.dart';
import 'i_authentication_repository.dart';

///
class AuthenticationRepository extends IAuthenticationRepository {
  ///
  AuthenticationRepository(
      {GoogleSignIn googleSignIn, FirebaseAuth firebaseAuth})
      : _googleSignIn = googleSignIn ?? GoogleSignIn.standard(),
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _firebaseAuth;

  ///
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
      // Using _googleSignIn.out() does not work ):
      await Future.wait([_firebaseAuth.signOut()]);
    } on Exception catch (_) {}
  }

  ///
  UserModel toUser(User firebaseUser) => UserModel(
      userId: firebaseUser.uid,
      email: firebaseUser.email,
      displayName: firebaseUser.displayName,
      photoUrl: firebaseUser.photoURL);
}
