import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:ps_mesainc/app/app_widget.dart';

import 'modules/login/domain/entities/user_credentials.dart';
import 'modules/login/domain/usecases/signup_with_email.dart';
import 'modules/login/external/datasources/login_datasource.dart';
import 'modules/login/infra/repositories/login_repository.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => Dio()),
        Bind((i) => LoginDataSourceImpl(i.get())),
        Bind((i) => LoginRepositoryImpl(i.get())),
        Bind((i) => SignUpWithEmailImpl(i.get())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, __) => LoginPage()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text("aSFF"),
          onPressed: () async {
            final doSignUp = Modular.get<SignUpWithEmail>();
            final userCredentials = UserCredentials(name: "Felipe M", email: "lipe1@mesq1.com", password: "123456");

            final user = await doSignUp(userCredentials);
            print("result = ");
            print(user.getOrElse);
          },
        ),
      ),
    );
  }
}
