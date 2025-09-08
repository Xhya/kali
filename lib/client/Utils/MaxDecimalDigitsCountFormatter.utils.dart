import 'package:flutter/services.dart';

class MaxDecimalDigitsCountFormatter extends TextInputFormatter {
  late int maxDigitsBeforeDecimal;
  late int maxDigitsAfterDecimal;

  MaxDecimalDigitsCountFormatter({
    required this.maxDigitsBeforeDecimal,
    required this.maxDigitsAfterDecimal,
  });

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String numericText = newValue.text.replaceAll(RegExp(r'[^0-9.]'), '');

    List<String> parts = numericText.split('.');
    String integerPart = parts[0];
    String decimalPart = parts.length > 1 ? parts[1] : '';

    if (integerPart.length > maxDigitsBeforeDecimal ||
        decimalPart.length > maxDigitsAfterDecimal) {
      return oldValue;
    }

    return TextEditingValue(
      text: numericText,
      selection: TextSelection.collapsed(offset: numericText.length),
    );
  }
}
