import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/logged_user.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/user_credentials.dart';
import 'package:ps_mesainc/app/modules/login/domain/errors/errors.dart';
import 'package:ps_mesainc/app/modules/login/domain/repositories/login_repository.dart';
import 'package:ps_mesainc/app/modules/login/domain/usecases/login_with_email.dart';
import 'package:ps_mesainc/app/modules/login/domain/usecases/logout.dart';

class LoginRepositoryMock extends Mock implements LoginRepository {}

class LoggedUserMock extends Mock implements LoggedUser {}

main() {
  final repositoryMock = LoginRepositoryMock();
  final doLogout = LogoutImpl(repositoryMock);

  test('should verify if exist User Logged', () async {
    when(repositoryMock.logout()).thenAnswer((_) async => Right(unit));

    var result = (await doLogout()).fold(id, id);
    expect(result, unit);
  });
  test('should return null if user not logged', () async {
    when(repositoryMock.logout()).thenAnswer((_) async => Left(ErrorCouldntLogout()));

    var result = (await doLogout()).fold(id, id);
    expect(result, isA<ErrorCouldntLogout>());
  });
}
