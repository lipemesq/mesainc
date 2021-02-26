import 'package:flutter/material.dart';
import 'package:ps_mesainc/app/modules/core/presenter/app_colors.dart';

class CalloutButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final BorderSide border;
  final Color fontColor;
  final Color backgroundColor;
  final Color splashColor;

  final whiteBorder = BorderSide(color: Colors.white);

  CalloutButton._({this.text, this.onPressed, this.border, this.fontColor, this.backgroundColor, this.splashColor});

  factory CalloutButton.white({@required String text, @required Function() onPressed}) {
    final blueBorder = BorderSide(color: AppColors.primaryBlue);
    final blueFont = AppColors.secondaryBlue;
    final whiteBg = Colors.white;

    return CalloutButton._(
      text: text,
      border: blueBorder,
      onPressed: onPressed,
      fontColor: blueFont,
      backgroundColor: whiteBg,
    );
  }

  factory CalloutButton.borderedBlue({@required String text, @required Function() onPressed}) {
    final whiteBorder = BorderSide(color: Colors.white);
    final whiteFont = Colors.white;
    final blueBg = AppColors.primaryBlue;
    final whiteSplash = Colors.white.withOpacity(0.7);

    return CalloutButton._(
      text: text,
      border: whiteBorder,
      onPressed: onPressed,
      fontColor: whiteFont,
      backgroundColor: blueBg,
      splashColor: whiteSplash,
    );
  }

  factory CalloutButton.blue({@required String text, @required Function() onPressed}) {
    final noBorder = BorderSide.none;
    final whiteFont = Colors.white;
    final blueBg = AppColors.primaryBlue;
    final whiteSplash = Colors.white.withOpacity(0.7);

    return CalloutButton._(
      text: text,
      border: noBorder,
      onPressed: onPressed,
      fontColor: whiteFont,
      backgroundColor: blueBg,
      splashColor: whiteSplash,
    );
  }

  factory CalloutButton.borderedWhite({@required String text, @required Function() onPressed}) {
    final blueBorder = BorderSide(color: AppColors.primaryBlue);
    final blueFont = AppColors.primaryBlue;
    final whiteBg = Colors.white;

    return CalloutButton._(
      text: text,
      border: blueBorder,
      onPressed: onPressed,
      fontColor: blueFont,
      backgroundColor: whiteBg,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: FlatButton(
        color: backgroundColor,
        splashColor: splashColor,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: fontColor,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: border,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
