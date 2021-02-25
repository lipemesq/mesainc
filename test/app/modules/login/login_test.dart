import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/logged_user.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/user_credentials.dart';
import 'package:ps_mesainc/app/modules/login/domain/usecases/login_with_email.dart';
import 'package:ps_mesainc/app/modules/login/external/datasources/login_datasource.dart';
import 'package:ps_mesainc/app/modules/login/infra/datasources/login_datasource.dart';
import 'package:ps_mesainc/app/modules/login/infra/models/user_data_model.dart';
import 'package:ps_mesainc/app/modules/login/infra/repositories/login_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginDataSourceMock extends Mock implements LoginDataSource {}

class LoggedUserMock extends Mock implements LoggedUser {}

class DioMock extends Mock implements Dio {}

main() {
  SharedPreferences.setMockInitialValues({});

  String _sucessfulResponse = jsonEncode({
    "token":
        "eyJhbGciOiJIUzI1NiJ9.eyJpZCI6OSwiZW1haWwiOiJqb2huQGRvZS5jb20ifQ.px43BWNshWtH09-NSGYuWgawHTeD8diEI2aYTqKwoA4"
  });

  String _emptyResponse = jsonEncode({});

  String _misspelledResponse = jsonEncode({
    "toqen":
        "eyJhbGciOiJIUzI1NiJ9.eyJpZCI6OSwiZW1haWwiOiJqb2huQGRvZS5jb20ifQ.px43BWNshWtH09-NSGYuWgawHTeD8diEI2aYTqKwoA4"
  });

  String _arrayResponse = jsonEncode([]);

  final dio = DioMock();

  final loginDatasource = LoginDataSourceImpl(dio);
  final loginRepository = LoginRepositoryImpl(loginDatasource);
  final doLogin = LoginWithEmailImpl(loginRepository);

  final userCredentials = UserCredentials(name: "test", email: "abc@def.com", password: "123456");

  final rightToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJpZCI6OSwiZW1haWwiOiJqb2huQGRvZS5jb20ifQ.px43BWNshWtH09-NSGYuWgawHTeD8diEI2aYTqKwoA4";

  test("caso de login completo com tudo ok", () async {
    when(dio.post(any, data: anyNamed('data')))
        .thenAnswer((_) async => Response(data: _sucessfulResponse, statusCode: 201));

    final result = (await doLogin(userCredentials));
    expect(result, isA<Right>());

    final right = result.getOrElse(() => null);
    expect(right.email, userCredentials.email);
    expect(right.token, rightToken);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final savedEncodedUser = sharedPreferences.getString("user01");
    expect(savedEncodedUser, isNotNull);
    final userData = UserDataModel.fromJson(savedEncodedUser);
    expect(userData.email, userCredentials.email);
    expect(userData.token, rightToken);
  });

  test("caso de login completo com resposta errada (vazia)", () async {
    when(dio.post(any, data: anyNamed('data')))
        .thenAnswer((_) async => Response(data: _emptyResponse, statusCode: 201));

    final result = (await doLogin(userCredentials));
    expect(result, isA<Left>());
  });

  test("caso de login completo com resposta errada (array)", () async {
    when(dio.post(any, data: anyNamed('data')))
        .thenAnswer((_) async => Response(data: _arrayResponse, statusCode: 201));

    final result = (await doLogin(userCredentials));
    expect(result, isA<Left>());
  });

  test("caso de login completo com resposta errada (misspelled)", () async {
    when(dio.post(any, data: anyNamed('data')))
        .thenAnswer((_) async => Response(data: _misspelledResponse, statusCode: 201));

    final result = (await doLogin(userCredentials));
    expect(result, isA<Left>());
  });

  test("caso de login completo com código http da mensagem errado 1", () async {
    when(dio.post(any, data: anyNamed('data')))
        .thenAnswer((_) async => Response(data: _emptyResponse, statusCode: 200));

    final result = (await doLogin(userCredentials));
    expect(result, isA<Left>());
  });

  test("caso de login completo com código http da mensagem errado 2", () async {
    when(dio.post(any, data: anyNamed('data')))
        .thenAnswer((_) async => Response(data: _emptyResponse, statusCode: 404));

    final result = (await doLogin(userCredentials));
    expect(result, isA<Left>());
  });
}
