import 'package:flutter/services.dart';

FilteringTextInputFormatter onlyNumbersFormatter() {
  return FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));
}
