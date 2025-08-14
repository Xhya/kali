import 'package:flutter/material.dart';
import 'package:kali/core/utils/String.extension.dart';

final inputState = InputState();

class InputState extends ChangeNotifier {
  final email = ValueNotifier<String>("");
  final password = ValueNotifier<String>("");

  bool get areEmailAndPasswordValid =>
      email.value.isNotEmpty &&
      password.value.isNotEmpty &&
      email.value.isValidEmail();

  InputState() {
    email.addListener(notifyListeners);
    password.addListener(notifyListeners);
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  reset() {
    email.value = "";
    password.value = "";
  }
}
