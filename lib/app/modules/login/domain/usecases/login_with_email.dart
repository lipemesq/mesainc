import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/logged_user.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/user_credentials.dart';
import 'package:ps_mesainc/app/modules/login/domain/repositories/login_repository.dart';

abstract class LoginWithEmail {
  Future<Either<Exception, LoggedUser>> call(UserCredentials credentials);
}

@Injectable(singleton: false)
class LoginWithEmailImpl implements LoginWithEmail {
  final LoginRepository repository;

  LoginWithEmailImpl(this.repository);

  @override
  Future<Either<Exception, LoggedUser>> call(UserCredentials credentials) {
    return repository.loginWithEmail(credentials);
  }
}
