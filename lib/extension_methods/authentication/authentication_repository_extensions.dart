import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/user/user.dart';

import '../../repositories/authentication/authentication_repository.dart';
import '../../utils/paths.dart';

///
extension AuthenticationRepositoryExtensions on AuthenticationRepository {
  ///
  static Future<void> addUserToFirestore(User firebaseUser) async {
    final _firebaseFirestore = FirebaseFirestore.instance;

    final _user = toUser(firebaseUser);
    await _firebaseFirestore.collection(Paths.users).add(_user.toDocument());
  }

  ///
  static Future<bool> checkIfUserExists(User firebaseUser) async {
    final _firebaseFirestore = FirebaseFirestore.instance;

    final _user = await _firebaseFirestore
        .collection(Paths.users)
        .doc(firebaseUser.email)
        .get();

    return _user.exists;
  }

  ///
  static UserModel toUser(User firebaseUser) => UserModel(
      userId: firebaseUser.uid,
      email: firebaseUser.email,
      displayName: firebaseUser.displayName,
      photoUrl: firebaseUser.photoURL);
}
