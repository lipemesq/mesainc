import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ps_mesainc/app/modules/login/core/errors/errors.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/logged_user.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/user_credentials.dart';
import 'package:ps_mesainc/app/modules/login/domain/repositories/login_repository.dart';

abstract class LoginWithEmail {
  Future<Either<LoginError, LoggedUser>> call(UserCredentials credentials);
}

@Injectable(singleton: false)
class LoginWithEmailImpl implements LoginWithEmail {
  final LoginRepository repository;

  LoginWithEmailImpl(this.repository);

  @override
  Future<Either<LoginError, LoggedUser>> call(UserCredentials credentials) async {
    final loginResult = await repository.loginWithEmail(credentials);

    if (loginResult.isLeft()) return Left(ErrorInvalidCredentials());
    final user = loginResult.getOrElse(() => null);

    final saveResult = await repository.saveAsLoggedUser(user);

    if (saveResult.isLeft()) return Left(ErrorSavingLoggedUser());

    return Right(user);
  }
}
