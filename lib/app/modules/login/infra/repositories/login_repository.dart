import 'package:ps_mesainc/app/modules/login/core/errors/errors.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/user_credentials.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/logged_user.dart';
import 'package:dartz/dartz.dart';
import 'package:ps_mesainc/app/modules/login/domain/repositories/login_repository.dart';
import 'package:ps_mesainc/app/modules/login/infra/datasources/login_datasource.dart';
import 'package:ps_mesainc/app/modules/login/infra/datasources/login_local_storage.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSource dataSource;
  final LoginLocalStorage localStorage;

  LoginRepositoryImpl(this.dataSource, this.localStorage);

  // final String userDataId = "user01";

  @override
  Future<Either<LoginError, LoggedUser>> getLoggedUser() async {
    try {
      var user = await localStorage.loadLoggedUser();
      if (user == null) return Left(ErrorNotLogged());

      return Right(user);
    } catch (e) {
      return Left(ErrorNotLogged());
    }
  }

  @override
  Future<Either<LoginError, LoggedUser>> loginWithEmail(UserCredentials credentials) async {
    try {
      var user = await dataSource.loginWithEmail(credentials);
      if (user != null) {
        return Right(user);
      } else
        return Left(ErrorInvalidCredentials());
    } catch (e) {
      return Left(ErrorInvalidCredentials());
    }
  }

  @override
  Future<Either<LoginError, LoggedUser>> signUpWithEmail(UserCredentials credentials) async {
    try {
      var user = await dataSource.signUpWithEmail(credentials);
      if (user != null)
        return Right(user);
      else
        return Left(ErrorAccountAlreadyExists());
    } catch (e) {
      throw e;
      return Left(ErrorAccountAlreadyExists());
    }
  }

  @override
  Future<Either<LoginError, Unit>> removeSavedUser() async {
    try {
      await localStorage.deleteLoggedUser();

      return Right(unit);
    } catch (e) {
      return Left(ErrorCouldntLogout());
    }
  }

  @override
  Future<Either<LoginError, Unit>> saveAsLoggedUser(LoggedUser user) async {
    try {
      await localStorage.saveLoggedUser(user);

      return Right(unit);
    } catch (e) {
      return Left(ErrorSavingLoggedUser());
    }
  }
}
