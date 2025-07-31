import 'package:flutter/material.dart';

final registerState = RegisterState();

class RegisterState extends ChangeNotifier {
  final isLoading = ValueNotifier<bool>(false);
  final code = ValueNotifier<String>("");

  RegisterState() {
    isLoading.addListener(notifyListeners);
    code.addListener(notifyListeners);
  }

  @override
  void dispose() {
    isLoading.dispose();
    code.dispose();
    super.dispose();
  }
}
