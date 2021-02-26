import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ps_mesainc/app/modules/core/presenter/app_colors.dart';
import 'package:ps_mesainc/app/modules/core/presenter/app_images.dart';
import 'package:ps_mesainc/app/modules/login/presenter/core/callout_button.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.primaryBlue,
        child: Column(
          children: [
            Spacer(),
            SvgPicture.asset(AppImgs.imgMesaLogo),
            SizedBox(height: 19),
            SvgPicture.asset(AppImgs.imgMesaNome),
            Spacer(),
            facebookButton(),
            SizedBox(height: 16),
            emailButton(),
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 32),
              child: signUpButton(),
            )
          ],
        ),
      ),
    );
  }

  Widget facebookButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CalloutButton.white(
        text: "Entrar com Facebook",
        onPressed: () => null,
      ),
    );
  }

  Widget emailButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CalloutButton.borderedBlue(
        text: "Entrar com e-mail",
        onPressed: openLoginWithEmail,
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

  openLoginWithEmail() {
    Modular.to.pushNamed("/loginEmail");
  }
}
