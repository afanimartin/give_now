import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../extension_methods/authentication/authentication_repository_extensions.dart';
import '../../models/user/user.dart';
import 'i_authentication_repository.dart';

///
class AuthenticationRepository extends IAuthenticationRepository {
  ///
  AuthenticationRepository({
    GoogleSignIn? googleSignIn,
    FirebaseAuth? firebaseAuth,
  })  : _googleSignIn = googleSignIn ??
            GoogleSignIn
                .standard(), // Will fail without GoogleSignIn.standard()
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _firebaseAuth;

  ///
  Stream<UserModel> get user => _firebaseAuth.authStateChanges().map(
      (firebaseUser) => firebaseUser == null
          ? UserModel.empty
          : AuthenticationRepositoryExtensions.toUser(firebaseUser));

  @override
  Future<void> logInWithGoogleAccount() async {
    try {
      final googleUser =
          await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;

      final googleCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      final _signedInUser =
          await _firebaseAuth.signInWithCredential(googleCredential);

      final _user = await AuthenticationRepositoryExtensions.checkIfUserExists(
          _signedInUser.user!);

      if (!_user) {
        await AuthenticationRepositoryExtensions.addUserToFirestore(
            _signedInUser.user!);
      }
    } on Exception catch (_) {}
  }

  @override
  Future<void> logOut() async {
    try {
      // Using _googleSignIn.out() does not work ):
      await _firebaseAuth.signOut();
    } on Exception catch (_) {}
  }
}
