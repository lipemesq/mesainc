import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/logged_user.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/user_credentials.dart';
import 'package:ps_mesainc/app/modules/login/domain/usecases/signup_with_email.dart';
import 'package:ps_mesainc/app/modules/login/external/datasources/login_datasource.dart';
import 'package:ps_mesainc/app/modules/login/external/datasources/login_local_storage.dart';
import 'package:ps_mesainc/app/modules/login/infra/datasources/login_datasource.dart';
import 'package:ps_mesainc/app/modules/login/infra/repositories/login_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginDataSourceMock extends Mock implements LoginDataSource {}

class LoggedUserMock extends Mock implements LoggedUser {}

class DioMock extends Mock implements Dio {}

main() {
  SharedPreferences.setMockInitialValues({});

  final _sucessfulResponse = {
    "token":
        "eyJhbGciOiJIUzI1NiJ9.eyJpZCI6OSwiZW1haWwiOiJqb2huQGRvZS5jb20ifQ.px43BWNshWtH09-NSGYuWgawHTeD8diEI2aYTqKwoA4"
  };

  final _emptyResponse = {};

  final _misspelledResponse = {
    "toqen":
        "eyJhbGciOiJIUzI1NiJ9.eyJpZCI6OSwiZW1haWwiOiJqb2huQGRvZS5jb20ifQ.px43BWNshWtH09-NSGYuWgawHTeD8diEI2aYTqKwoA4"
  };

  final _arrayResponse = [];

  final dio = DioMock();

  final loginDatasource = LoginDataSourceImpl(dio);
  final loginLocalStorage = LoginLocalStorageImpl();
  final loginRepository = LoginRepositoryImpl(loginDatasource, loginLocalStorage);
  final doSignUp = SignUpWithEmailImpl(loginRepository);

  final userCredentials = UserCredentials(name: "test", email: "abc@def.com", password: "123456");

  final rightToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJpZCI6OSwiZW1haWwiOiJqb2huQGRvZS5jb20ifQ.px43BWNshWtH09-NSGYuWgawHTeD8diEI2aYTqKwoA4";

  test("caso de signUp completo com tudo ok", () async {
    when(dio.post(any, data: anyNamed('data')))
        .thenAnswer((_) async => Response(data: _sucessfulResponse, statusCode: 201));

    final result = (await doSignUp(userCredentials));
    expect(result, isA<Right>());

    final right = result.getOrElse(() => null);
    expect(right.email, userCredentials.email);
    expect(right.token, rightToken);
  });

  test("caso de signUp completo com resposta errada (vazia)", () async {
    when(dio.post(any, data: anyNamed('data')))
        .thenAnswer((_) async => Response(data: _emptyResponse, statusCode: 201));

    final result = (await doSignUp(userCredentials));
    expect(result, isA<Left>());
  });

  test("caso de signUp completo com resposta errada (array)", () async {
    when(dio.post(any, data: anyNamed('data')))
        .thenAnswer((_) async => Response(data: _arrayResponse, statusCode: 201));

    final result = (await doSignUp(userCredentials));
    expect(result, isA<Left>());
  });

  test("caso de signUp completo com resposta errada (misspelled)", () async {
    when(dio.post(any, data: anyNamed('data')))
        .thenAnswer((_) async => Response(data: _misspelledResponse, statusCode: 201));

    final result = (await doSignUp(userCredentials));
    expect(result, isA<Left>());
  });

  test("caso de signUp completo com código http da mensagem errado 1", () async {
    when(dio.post(any, data: anyNamed('data')))
        .thenAnswer((_) async => Response(data: _emptyResponse, statusCode: 200));

    final result = (await doSignUp(userCredentials));
    expect(result, isA<Left>());
  });

  test("caso de signUp completo com código http da mensagem errado 2", () async {
    when(dio.post(any, data: anyNamed('data')))
        .thenAnswer((_) async => Response(data: _emptyResponse, statusCode: 404));

    final result = (await doSignUp(userCredentials));
    expect(result, isA<Left>());
  });
}
