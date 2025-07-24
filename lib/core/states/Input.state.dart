import 'package:flutter/material.dart';

final inputState = InputState();

class InputState extends ChangeNotifier {
  final email = ValueNotifier<String>("");
  final password = ValueNotifier<String>("");

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
}
