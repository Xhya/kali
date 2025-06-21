import 'package:flutter/material.dart';

var quickAddMealState = QuickAddMealState();

class QuickAddMealState extends ChangeNotifier {
  final isInAddingMode = ValueNotifier<bool>(false);
  final isLoading = ValueNotifier<bool>(false);
  final userMealText = ValueNotifier<String>("");

  QuickAddMealState() {
    isInAddingMode.addListener(notifyListeners);
    isLoading.addListener(notifyListeners);
    userMealText.addListener(notifyListeners);
  }

  @override
  void dispose() {
    isInAddingMode.dispose();
    isLoading.dispose();
    userMealText.dispose();
    super.dispose();
  }
}
