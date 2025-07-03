import 'package:flutter/material.dart';

var startFormState = StartFormState();

class StartFormState extends ChangeNotifier {
  final size = ValueNotifier<String>("");
  final weight = ValueNotifier<String>("");
  final age = ValueNotifier<String>("");
  final isLoading = ValueNotifier<bool>(false);
  bool get isSubmitButtonDisabled =>
      size.value.isEmpty || weight.value.isEmpty || age.value.isEmpty;

  StartFormState() {
    size.addListener(notifyListeners);
    weight.addListener(notifyListeners);
    age.addListener(notifyListeners);
    isLoading.addListener(notifyListeners);
  }

  @override
  void dispose() {
    size.dispose();
    weight.dispose();
    age.dispose();
    isLoading.dispose();
    super.dispose();
  }
}
