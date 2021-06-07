import '../../models/user/user.dart';
///
abstract class IAuthenticationRepository {
  ///
  Future<void> logInWithGoogleAccount();
  ///
  Future<UserModel> getCurrentUser();
  ///
  Future<void> logOut();
}
