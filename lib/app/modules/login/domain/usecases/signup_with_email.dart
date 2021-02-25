import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ps_mesainc/app/modules/login/core/errors/errors.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/logged_user.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/user_credentials.dart';
import 'package:ps_mesainc/app/modules/login/domain/repositories/login_repository.dart';

abstract class SignUpWithEmail {
  Future<Either<LoginError, LoggedUser>> call(UserCredentials credentials);
}

@Injectable(singleton: false)
class SignUpWithEmailImpl implements SignUpWithEmail {
  final LoginRepository repository;

  SignUpWithEmailImpl(this.repository);

  @override
  Future<Either<LoginError, LoggedUser>> call(UserCredentials credentials) {
    return repository.signUpWithEmail(credentials);
  }
}
