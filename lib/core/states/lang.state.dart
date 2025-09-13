import 'package:flutter/material.dart';
import 'package:kali/core/services/Locale.service.dart';

final langState = LangState();

class LangState extends ChangeNotifier {
  final currentLang = ValueNotifier<LocaleEnum>(LocaleEnum.fr);

  LangState() {
    currentLang.addListener(notifyListeners);
  }

  @override
  void dispose() {
    currentLang.dispose();
    super.dispose();
  }
}
