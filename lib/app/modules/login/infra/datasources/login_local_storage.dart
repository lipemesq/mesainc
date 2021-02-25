import 'package:dartz/dartz.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/logged_user.dart';

abstract class LoginLocalStorage {
  Future<LoggedUser> loadLoggedUser();

  Future<void> saveLoggedUser(LoggedUser user);

  Future<void> deleteLoggedUser();
}
