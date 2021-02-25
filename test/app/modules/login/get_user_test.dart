import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/logged_user.dart';
import 'package:ps_mesainc/app/modules/login/domain/usecases/get_logged_user.dart';
import 'package:ps_mesainc/app/modules/login/external/datasources/login_datasource.dart';
import 'package:ps_mesainc/app/modules/login/infra/datasources/login_datasource.dart';
import 'package:ps_mesainc/app/modules/login/infra/models/user_data_model.dart';
import 'package:ps_mesainc/app/modules/login/infra/repositories/login_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginDataSourceMock extends Mock implements LoginDataSource {}

class LoggedUserMock extends Mock implements LoggedUser {}

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();
  final loginDatasource = LoginDataSourceImpl(dio);
  final loginRepository = LoginRepositoryImpl(loginDatasource);
  final doGetLoggedUser = GetLoggedUserImpl(loginRepository);

  final loggedUser = UserDataModel(name: "test", email: "abc@def.com", token: "token1");

  group("Teste com resposta certa", () {
    setUp(() {
      SharedPreferences.setMockInitialValues({
        "user01": loggedUser.toJson(),
      });
    });

    test("caso de get user completo com tudo ok", () async {
      final result = (await doGetLoggedUser());
      expect(result, isA<Right>());

      final right = result.getOrElse(() => null);
      expect(right.email, loggedUser.email);
    });
  });

  group("Teste com resposta errada", () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test("caso de get user completo com resposta errada (null)", () async {
      final result = (await doGetLoggedUser());
      expect(result, isA<Left>());
    });
  });
}
