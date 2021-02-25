import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ps_mesainc/app/modules/login/domain/repositories/login_repository.dart';

abstract class Logout {
  Future<Either<Exception, Unit>> call();
}

@Injectable(singleton: false)
class LogoutImpl implements Logout {
  final LoginRepository repository;

  LogoutImpl(this.repository);

  @override
  Future<Either<Exception, Unit>> call() {
    return repository.logout();
  }
}
