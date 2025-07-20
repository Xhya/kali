import 'package:flutter/services.dart';

class InputWithTextFormatter extends TextInputFormatter {

  String extension = "";

  InputWithTextFormatter({this.extension = ""});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(
        text: "${newValue.text} $extension", selection: updateCursorPosition(newValue.text));
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}
