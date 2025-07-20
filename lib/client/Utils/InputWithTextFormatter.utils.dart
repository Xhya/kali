import 'package:flutter/services.dart';

class InputWithTextFormatter extends TextInputFormatter {

  String extension = "";

  InputWithTextFormatter({this.extension = ""});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
      if (newValue.text.isEmpty) {
        return newValue.copyWith(text: "", selection: TextSelection.collapsed(offset: 0));
      }

    return newValue.copyWith(
        text: "${newValue.text} $extension", selection: updateCursorPosition(newValue.text));
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}
