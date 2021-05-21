import '../../models/user/user_model.dart';

abstract class IAuthenticationRepository {
  Future<void> logInWithGoogleAccount();

  Future<UserModel> getCurrentUser();

  Future<void> logOut();
}
