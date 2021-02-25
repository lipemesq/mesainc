import 'package:ps_mesainc/app/modules/login/domain/entities/logged_user.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/user_credentials.dart';

abstract class LoginDataSource {
  Future<LoggedUser> getCurrentUser();

  Future<LoggedUser> loginWithEmail(UserCredentials credentials);

  Future<LoggedUser> signUpWithEmail(UserCredentials credentials);

  Future<void> logout();
}
