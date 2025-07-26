import 'package:flutter/services.dart';

class MaxCharactersCountFormatter extends TextInputFormatter {
  late int maxLength;

  MaxCharactersCountFormatter({this.maxLength = 1000});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.length <= maxLength) {
      return newValue;
    }

    return oldValue;
  }
}
