import 'package:flutter/services.dart';

class MaxCharactersCountFormatter extends TextInputFormatter {
  late int maxLength;

  MaxCharactersCountFormatter({this.maxLength = 100});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final regex = RegExp(r'\d+');
    final match = regex.firstMatch(newValue.text);

    if (match?.group(0) != null && match!.group(0)!.length <= maxLength) {
      return newValue;
    }

    return oldValue;
  }
}
