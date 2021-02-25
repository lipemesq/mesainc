import 'package:ps_mesainc/app/modules/login/core/errors/errors.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/logged_user.dart';
import 'package:dartz/dartz.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/user_credentials.dart';

abstract class LoginRepository {
  Future<Either<LoginError, LoggedUser>> getLoggedUser();

  Future<Either<LoginError, Unit>> saveAsLoggedUser(LoggedUser user);

  Future<Either<LoginError, Unit>> removeSavedUser();

  Future<Either<LoginError, LoggedUser>> loginWithEmail(UserCredentials credentials);

  Future<Either<LoginError, LoggedUser>> signUpWithEmail(UserCredentials credentials);
}
