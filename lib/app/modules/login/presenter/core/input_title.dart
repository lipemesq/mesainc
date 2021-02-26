import 'package:flutter/material.dart';
import 'package:ps_mesainc/app/modules/core/presenter/app_colors.dart';

class InputTitle extends StatelessWidget {
  final String text;

  InputTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.blackBlue,
        ),
      ),
    );
  }
}
