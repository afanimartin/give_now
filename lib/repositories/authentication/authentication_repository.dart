import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../models/user/user.dart';
import '../../utils/paths.dart';
import 'i_authentication_repository.dart';

///
class AuthenticationRepository extends IAuthenticationRepository {
  ///
  AuthenticationRepository(
      {GoogleSignIn googleSignIn,
      FirebaseAuth firebaseAuth,
      FirebaseFirestore firebaseFirestore})
      : _googleSignIn = googleSignIn ??
            GoogleSignIn
                .standard(), // Will fail without GoogleSignIn.standard()
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

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

      final _signedInUser =
          await _firebaseAuth.signInWithCredential(googleCredential);

      await addUserToFirestore(_signedInUser.user);
    } on Exception catch (_) {}
  }

  ///
  Future<void> addUserToFirestore(User firebaseUser) async {
    final _user = toUser(firebaseUser);
    await _firebaseFirestore.collection(Paths.users).add(_user.toDocument());
  }

  @override
  Future<void> logOut() async {
    try {
      // Using _googleSignIn.out() does not work ):
      await _firebaseAuth.signOut();
    } on Exception catch (_) {}
  }

  ///
  UserModel toUser(User firebaseUser) => UserModel(
      userId: firebaseUser.uid,
      email: firebaseUser.email,
      displayName: firebaseUser.displayName,
      photoUrl: firebaseUser.photoURL);
}
