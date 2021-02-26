import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/user_credentials.dart';
import 'package:ps_mesainc/app/modules/login/domain/usecases/login_with_email.dart';
import 'package:asuka/asuka.dart' as asuka;

part 'login_controller.g.dart';

@Injectable()
class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  String email = "";
  String password = "";

  String setEmail(String newEmail) {
    email = newEmail;
    return email;
  }

  String setPassword(String newPassword) {
    password = newPassword;
    return password;
  }

  tryLogin() async {
    final doLoginWithEmail = Modular.get<LoginWithEmail>();
    final result = await doLoginWithEmail(
      UserCredentials(email: email, password: password),
    );
    if (result.isRight()) {
      navigateToFeed();
    } else {
      showErrorSnackbar();
    }
  }

  navigateToFeed() {
    Modular.to.pushNamedAndRemoveUntil("/feed", (r) => r == null); //.popAndPushNamed("/feed");
  }

  showErrorSnackbar() {
    final snackBar = SnackBar(
      content: Text(
        'Credenciais inválidas. Tente novamente.',
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
