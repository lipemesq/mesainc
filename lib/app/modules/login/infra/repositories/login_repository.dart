import 'package:ps_mesainc/app/modules/login/domain/entities/user_credentials.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/logged_user.dart';
import 'package:dartz/dartz.dart';
import 'package:ps_mesainc/app/modules/login/domain/errors/errors.dart';
import 'package:ps_mesainc/app/modules/login/domain/repositories/login_repository.dart';
import 'package:ps_mesainc/app/modules/login/infra/datasources/login_datasource.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSource dataSource;

  LoginRepositoryImpl(this.dataSource);

  @override
  Future<Either<Exception, LoggedUser>> getLoggedUser() async {
    try {
      var user = await dataSource.getCurrentUser();
      return Right(user);
    } catch (e) {
      print("catch $e");
      return Left(ErrorNotLogged());
    }
  }

  @override
  Future<Either<Exception, LoggedUser>> loginWithEmail(UserCredentials credentials) async {
    try {
      var user = await dataSource.loginWithEmail(credentials);
      if (user != null)
        return Right(user);
      else
        return Left(ErrorInvalidCredentials());
    } catch (e) {
      return Left(ErrorInvalidCredentials());
    }
  }

  @override
  Future<Either<Exception, Unit>> logout() async {
    try {
      await dataSource.logout();
      return Right(unit);
    } catch (e) {
      return Left(ErrorCouldntLogout());
    }
  }

  @override
  Future<Either<Exception, LoggedUser>> signUpWithEmail(UserCredentials credentials) async {
    try {
      var user = await dataSource.signUpWithEmail(credentials);
      if (user != null)
        return Right(user);
      else
        return Left(ErrorAccountAlreadyExists());
    } catch (e) {
      return Left(ErrorAccountAlreadyExists());
    }
  }
}
