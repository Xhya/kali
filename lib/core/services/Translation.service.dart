import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kalori/core/services/String.extension.dart';

String t(String key, [List<String>? args]) {
  String text = TranslationService().textFR[key];

  if (args != null) {
    for (int i = 0; i < args.length; i++) {
      text = text.replaceAll('[$i]', args[i]);
    }
  }

  return text.capitalize();
}

class TranslationService extends ChangeNotifier {
  static final TranslationService _singleton = TranslationService._internal();

  factory TranslationService() {
    return _singleton;
  }

  TranslationService._internal();

  var textFR = {};

  init() async {
    try {
      var input = await rootBundle.loadString("assets/lang/fr.json");
      textFR = jsonDecode(input);
    } catch (e) {
      print(e);
    }
  }
}
