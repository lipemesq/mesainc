import 'package:flutter/material.dart';
import 'package:ps_mesainc/app/modules/core/presenter/app_colors.dart';

import 'input_title.dart';

class TextInputFormField extends StatelessWidget {
  final String title;
  final TextInputType keyboardType;
  final String Function(String) validator;
  final String Function(String) onSave;
  final bool lastField;
  final bool obscure;

  const TextInputFormField({
    @required this.title,
    this.keyboardType,
    this.validator,
    this.lastField = false,
    this.obscure = false,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputTitle(title),
        TextFormField(
          validator: validator,
          keyboardType: keyboardType,
          textInputAction: lastField ? TextInputAction.done : TextInputAction.next,
          obscureText: obscure,
          onSaved: onSave,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.primaryGray,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
