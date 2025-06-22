import 'package:flutter/material.dart';

var startFormState = StartFormState();

class StartFormState extends ChangeNotifier {
  final size = ValueNotifier<String>("");
  final weight = ValueNotifier<String>("");
  final age = ValueNotifier<String>("");

  StartFormState() {
    size.addListener(notifyListeners);
    weight.addListener(notifyListeners);
    age.addListener(notifyListeners);
  }

  @override
  void dispose() {
    size.dispose();
    weight.dispose();
    age.dispose();
    super.dispose();
  }
}
