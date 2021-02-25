import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/logged_user.dart';
import 'package:ps_mesainc/app/modules/login/domain/errors/errors.dart';
import 'package:ps_mesainc/app/modules/login/domain/repositories/login_repository.dart';
import 'package:ps_mesainc/app/modules/login/domain/usecases/get_logged_user.dart';

class LoginRepositoryMock extends Mock implements LoginRepository {}

class LoggedUserMock extends Mock implements LoggedUser {}

main() {
  final repositoryMock = LoginRepositoryMock();
  final doGetLoggedUser = GetLoggedUserImpl(repositoryMock);

  test("caso de resgate de conta logada", () async {
    when(repositoryMock.getLoggedUser()).thenAnswer((_) async => Right(LoggedUserMock()));
    var result = (await doGetLoggedUser()).fold(id, id);
    expect(result, isA<LoggedUser>());
  });

  test("caso de resgate sem conta logada", () async {
    when(repositoryMock.getLoggedUser()).thenAnswer((_) async => Left(ErrorNotLogged()));
    var result = (await doGetLoggedUser()).fold(id, id);
    expect(result, isA<ErrorNotLogged>());
  });
}
