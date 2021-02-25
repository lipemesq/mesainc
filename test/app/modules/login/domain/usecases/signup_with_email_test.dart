import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/logged_user.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/user_credentials.dart';
import 'package:ps_mesainc/app/modules/login/core/errors/errors.dart';
import 'package:ps_mesainc/app/modules/login/domain/repositories/login_repository.dart';
import 'package:ps_mesainc/app/modules/login/domain/usecases/signup_with_email.dart';

class LoginRepositoryMock extends Mock implements LoginRepository {}

class LoggedUserMock extends Mock implements LoggedUser {}

main() {
  final repositoryMock = LoginRepositoryMock();
  final doSignUpWithEmail = SignUpWithEmailImpl(repositoryMock);

  final userCredentials = UserCredentials(name: "test", email: "abc@def.com", password: "123456");

  test("caso de signup ok", () async {
    when(repositoryMock.signUpWithEmail(any)).thenAnswer((_) async => Right(LoggedUserMock()));

    var result = (await doSignUpWithEmail(userCredentials)).fold(id, id);
    expect(result, isA<LoggedUser>());
  });

  test("caso de singup com erro", () async {
    when(repositoryMock.signUpWithEmail(any)).thenAnswer((_) async => Left(ErrorAccountAlreadyExists()));
    var result = (await doSignUpWithEmail(userCredentials)).fold(id, id);
    expect(result, isA<ErrorAccountAlreadyExists>());
  });
}
