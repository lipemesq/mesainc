import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ps_mesainc/app/modules/core/presenter/app_colors.dart';

import 'input_title.dart';

class TextInputFormField extends StatelessWidget {
  final String title;
  final TextInputType keyboardType;
  final String Function(String) validator;
  final String Function(String) onSave;
  final bool lastField;
  final bool obscure;
  final bool isDate;

  const TextInputFormField({
    @required this.title,
    this.keyboardType,
    this.validator,
    this.lastField = false,
    this.obscure = false,
    this.onSave,
    this.isDate = false,
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
          inputFormatters: isDate ? [DateTextFormatter()] : [],
          maxLength: isDate ? 10 : null,
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

class DateTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    //this fixes backspace bug
    if (oldValue.text.length >= newValue.text.length) {
      return newValue;
    }

    var dateText = _addSeperators(newValue.text, '/');
    return newValue.copyWith(text: dateText, selection: updateCursorPosition(dateText));
  }

  String _addSeperators(String value, String seperator) {
    value = value.replaceAll('/', '');
    var newString = '';
    for (int i = 0; i < value.length; i++) {
      newString += value[i];
      if (i == 1) {
        newString += seperator;
      }
      if (i == 3) {
        newString += seperator;
      }
    }
    return newString;
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}
