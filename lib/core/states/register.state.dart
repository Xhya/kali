import 'package:flutter/material.dart';

final registerState = RegisterState();

class RegisterState extends ChangeNotifier {
  final isLoading = ValueNotifier<bool>(false);

  RegisterState() {
    isLoading.addListener(notifyListeners);
  }

  @override
  void dispose() {
    isLoading.dispose();
    super.dispose();
  }
}
