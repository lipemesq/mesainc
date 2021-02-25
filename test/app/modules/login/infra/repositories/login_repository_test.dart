import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/logged_user.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/user_credentials.dart';
import 'package:ps_mesainc/app/modules/login/core/errors/errors.dart';
import 'package:ps_mesainc/app/modules/login/infra/datasources/login_datasource.dart';
import 'package:ps_mesainc/app/modules/login/infra/repositories/login_repository.dart';

class LoginDataSourceMock extends Mock implements LoginDataSource {}

class LoggedUserMock extends Mock implements LoggedUser {}

main() {
  final datasourceMock = LoginDataSourceMock();
  final loginRepository = LoginRepositoryImpl(datasourceMock);
  final userCredentials = UserCredentials(email: "abc@def.com", password: "123456");

  // - GET USER
  group("Recuperar usuário logado, no repositório", () {
    test("caso de pegar o usuário logado no repositório", () async {
      when(datasourceMock.getCurrentUser()).thenAnswer((_) async => LoggedUserMock());

      var result = (await loginRepository.getLoggedUser()).fold(id, id);
      expect(result, isA<LoggedUser>());
    });
    test("caso de pegar o usuário não logado no repositório", () async {
      when(datasourceMock.getCurrentUser()).thenThrow((_) async => ErrorNotLogged());

      var result = (await loginRepository.getLoggedUser()).fold(id, id);
      expect(result, isA<ErrorNotLogged>());
    });
  });

  // - LOGIN WITH EMAIL
  group("Login com email, no repositório", () {
    test("caso de logar com o email no repositório", () async {
      when(datasourceMock.loginWithEmail(any)).thenAnswer((_) async => LoggedUserMock());

      var result = (await loginRepository.loginWithEmail(userCredentials)).fold(id, id);
      expect(result, isA<LoggedUser>());
    });
    test("caso de falhar com Exception no login com email", () async {
      when(datasourceMock.loginWithEmail(any)).thenThrow((_) async => ErrorInvalidCredentials());

      var result = (await loginRepository.loginWithEmail(userCredentials)).fold(id, id);
      expect(result, isA<ErrorInvalidCredentials>());
    });

    test("caso de falhar com Null no login com email", () async {
      when(datasourceMock.loginWithEmail(any)).thenReturn(null);

      var result = (await loginRepository.loginWithEmail(userCredentials)).fold(id, id);
      expect(result, isA<ErrorInvalidCredentials>());
    });
  });

  // - SIGNUP WITH EMAIL
  group("Cadastro com email, no repositório", () {
    test("caso de cadastrar ok com o email no repositório", () async {
      when(datasourceMock.signUpWithEmail(any)).thenAnswer((_) async => LoggedUserMock());

      var result = (await loginRepository.signUpWithEmail(userCredentials)).fold(id, id);
      expect(result, isA<LoggedUser>());
    });
    test("caso de falhar com Exception no cadastro com email", () async {
      when(datasourceMock.signUpWithEmail(any)).thenThrow((_) async => ErrorAccountAlreadyExists());

      var result = (await loginRepository.signUpWithEmail(userCredentials)).fold(id, id);
      expect(result, isA<ErrorAccountAlreadyExists>());
    });
  });

  // - LOGOUT
  group("Logout, no repositório", () {
    test("caso de logout ok", () async {
      when(datasourceMock.logout()).thenAnswer((_) async => unit);

      var result = (await loginRepository.logout()).fold(id, id);
      expect(result, isA<Unit>());
    });
    test("caso de falha no logout", () async {
      when(datasourceMock.logout()).thenThrow((_) async => ErrorCouldntLogout());

      var result = (await loginRepository.logout()).fold(id, id);
      expect(result, isA<ErrorCouldntLogout>());
    });
  });
}
