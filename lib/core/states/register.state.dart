import 'package:flutter/material.dart';

final registerState = RegisterState();

class RegisterState extends ChangeNotifier {
  final email = ValueNotifier<String>("");
  final password = ValueNotifier<String>("");

  RegisterState() {
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
