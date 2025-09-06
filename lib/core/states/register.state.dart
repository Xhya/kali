import 'package:flutter/material.dart';

final registerState = RegisterState();

class RegisterState extends ChangeNotifier {
  final isLoading = ValueNotifier<bool>(false);
  final code = ValueNotifier<String>("");
  final error = ValueNotifier<String?>(null);

  RegisterState() {
    isLoading.addListener(notifyListeners);
    code.addListener(notifyListeners);
    error.addListener(notifyListeners);
  }

  @override
  void dispose() {
    isLoading.dispose();
    code.dispose();
    error.dispose();
    super.dispose();
  }
}
