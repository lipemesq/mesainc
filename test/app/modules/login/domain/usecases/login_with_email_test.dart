import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/logged_user.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/user_credentials.dart';
import 'package:ps_mesainc/app/modules/login/core/errors/errors.dart';
import 'package:ps_mesainc/app/modules/login/domain/repositories/login_repository.dart';
import 'package:ps_mesainc/app/modules/login/domain/usecases/login_with_email.dart';

class LoginRepositoryMock extends Mock implements LoginRepository {}

class LoggedUserMock extends Mock implements LoggedUser {}

main() {
  final repositoryMock = LoginRepositoryMock();
  final doLoginWithEmail = LoginWithEmailImpl(repositoryMock);

  final userCredentials = UserCredentials(email: "abc@def.com", password: "123456");

  test("caso de login com credenciais corretas", () async {
    when(repositoryMock.loginWithEmail(any)).thenAnswer((_) async => Right(LoggedUserMock()));
    when(repositoryMock.saveAsLoggedUser(any)).thenAnswer((_) async => Right(unit));

    var result = (await doLoginWithEmail(userCredentials)).fold(id, id);
    expect(result, isA<LoggedUser>());
  });

  test("caso de login com credenciais erradas", () async {
    when(repositoryMock.loginWithEmail(any)).thenAnswer((_) async => Left(ErrorNotLogged()));
    when(repositoryMock.saveAsLoggedUser(any)).thenAnswer((_) async => Right(unit));

    var result = (await doLoginWithEmail(userCredentials)).fold(id, id);
    expect(result, isA<ErrorInvalidCredentials>());
  });

  test("caso de falha ao logar", () async {
    when(repositoryMock.loginWithEmail(any)).thenAnswer((_) async => Right(LoggedUserMock()));
    when(repositoryMock.saveAsLoggedUser(any)).thenAnswer((_) async => Left(ErrorSavingLoggedUser()));

    var result = (await doLoginWithEmail(userCredentials)).fold(id, id);
    expect(result, isA<ErrorSavingLoggedUser>());
  });
}
