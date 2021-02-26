import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ps_mesainc/app/modules/core/presenter/app_colors.dart';
import 'package:ps_mesainc/app/modules/login/presenter/core/callout_button.dart';
import 'package:ps_mesainc/app/modules/login/presenter/core/text_input_field.dart';
import 'signup_controller.dart';

class SignupPage extends StatefulWidget {
  final String title;
  const SignupPage({Key key, this.title = "Signup"}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends ModularState<SignupPage, SignupController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle(),
        leading: appBarCloseButton(),
        backgroundColor: AppColors.primaryBlue,
      ),
      backgroundColor: AppColors.background,
      body: GestureDetector(
        onTap: dismissKeyboard,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 26),
                        child: TextInputFormField(title: "Nome"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 26),
                        child: TextInputFormField(title: "E-mail"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 26),
                        child: TextInputFormField(
                          title: "Senha",
                          obscure: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 26),
                        child: TextInputFormField(
                          title: "Confirmar senha",
                          obscure: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 26),
                        child: TextInputFormField(
                          title: "Data de nascimento - opcional",
                          keyboardType: TextInputType.datetime,
                          lastField: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 26),
                        child: CalloutButton.blue(text: "Cadastrar", onPressed: () => null),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconButton appBarCloseButton() {
    return IconButton(
      icon: Icon(Icons.close),
      iconSize: 32,
      padding: const EdgeInsets.all(0),
      onPressed: () => Modular.to.pop(),
    );
  }

  Text appBarTitle() {
    return Text(
      "Cadastrar",
      style: TextStyle(
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    );
  }

  dismissKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
