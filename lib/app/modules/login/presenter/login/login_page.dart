import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ps_mesainc/app/modules/core/presenter/app_colors.dart';
import 'package:ps_mesainc/app/modules/core/presenter/app_images.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/user_credentials.dart';
import 'package:ps_mesainc/app/modules/login/domain/usecases/login_with_email.dart';
import 'package:ps_mesainc/app/modules/login/presenter/core/callout_button.dart';
import 'package:ps_mesainc/app/modules/login/presenter/core/text_input_field.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  //use 'controller' variable to access controller
  final _formKey = GlobalKey<FormState>();

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
                padding: const EdgeInsets.only(top: 40, bottom: 55),
                child: SvgPicture.asset(AppImgs.imgLogin),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    emailField(),
                    SizedBox(height: 26),
                    passwordField(),
                  ],
                ),
              ),
              SizedBox(height: 32),
              loginButton(),
              SizedBox(height: 134),
              loginWithFacebookButton(),
              SizedBox(height: 26),
              signUpButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget emailField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextInputFormField(
        title: "E-mail",
        validator: (email) {
          if (email.contains("@") && email.contains("."))
            return null;
          else
            return "Email inválido.";
        },
        onSave: controller.setEmail,
      ),
    );
  }

  Widget passwordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextInputFormField(
        title: "Senha",
        lastField: true,
        obscure: true,
        validator: (password) {
          return password.isEmpty ? "A senha não foi inserida." : null;
        },
        onSave: controller.setPassword,
      ),
    );
  }

  Widget loginButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CalloutButton.blue(
        text: "Login",
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            dismissKeyboard();
            controller.tryLogin();
          }
        },
      ),
    );
  }

  Widget loginWithFacebookButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CalloutButton.borderedWhite(
        text: "Entrar com Facebook",
        onPressed: () => null,
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
      "Entrar com e-mail",
      style: TextStyle(
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    );
  }

  Widget signUpButton() {
    return FlatButton(
      child: RichText(
        text: TextSpan(
          text: 'Não tenho conta. ',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: AppColors.primaryBlue,
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'Cadastrar',
              style: TextStyle(color: AppColors.link),
            ),
          ],
        ),
      ),
      onPressed: openSignUp,
    );
  }

  openSignUp() {
    Modular.to.pushNamed("/signUp");
  }

  dismissKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
