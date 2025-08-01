import 'package:flutter/material.dart';

final textsState = TextsState();

class TextsState extends ChangeNotifier {
  final needEmailText = ValueNotifier<String>("");

  TextsState() {
    needEmailText.addListener(notifyListeners);
  }

  @override
  void dispose() {
    needEmailText.dispose();
    super.dispose();
  }
}
