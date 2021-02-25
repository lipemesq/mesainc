import 'package:ps_mesainc/app/modules/login/domain/entities/logged_user.dart';
import 'package:dartz/dartz.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/user_credentials.dart';

abstract class LoginRepository {
  Future<Either<Exception, LoggedUser>> getLoggedUser();

  Future<Either<Exception, LoggedUser>> loginWithEmail(UserCredentials credentials);

  Future<Either<Exception, Unit>> logout();
}
