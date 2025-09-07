import 'package:flutter/services.dart';

FilteringTextInputFormatter decimalFormatter() {
  return FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'));
}
