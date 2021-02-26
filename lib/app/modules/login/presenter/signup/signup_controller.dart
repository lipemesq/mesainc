import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/user_credentials.dart';
import 'package:ps_mesainc/app/modules/login/domain/usecases/signup_with_email.dart';
import 'package:asuka/asuka.dart' as asuka;

part 'signup_controller.g.dart';

@Injectable()
class SignupController = _SignupControllerBase with _$SignupController;

abstract class _SignupControllerBase with Store {
  String name;
  String email;
  String password;
  String againPassaword;
  String birthday;

  String setName(String newName) {
    name = newName;
    return email;
  }

  String setEmail(String newEmail) {
    email = newEmail;
    return email;
  }

  String setPassword(String newPassword) {
    password = newPassword;
    return password;
  }

  String setAgainPassword(String newAgainPassword) {
    againPassaword = newAgainPassword;
    return againPassaword;
  }

  String setBirthday(String newBirthday) {
    birthday = newBirthday;
    return birthday;
  }

  signUp() async {
    final doSignUp = Modular.get<SignUpWithEmail>();
    final result = await doSignUp(UserCredentials(name: name, email: email, password: password));
    if (result.isRight()) {
      showOkSnackbar();
      Modular.to.pop();
    } else {
      showErrorSnackbar();
    }
  }

  showOkSnackbar() {
    final snackBar = SnackBar(
      content: Text(
        'Cadastro realizado com sucesso!',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w700,
        ),
      ),
      backgroundColor: Colors.green.shade900,
    );

    asuka.showSnackBar(snackBar);
  }

  showErrorSnackbar() {
    final snackBar = SnackBar(
      content: Text(
        'Não foi possível realizar o cadastro. Tente novamente.',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w700,
        ),
      ),
      backgroundColor: Colors.red.shade900,
    );

    asuka.showSnackBar(snackBar);
  }
}
