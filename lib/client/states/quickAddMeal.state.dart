import 'package:flutter/material.dart';

var quickAddMealState = QuickAddMealState();

class QuickAddMealState extends ChangeNotifier {
  final isInAddingMode = ValueNotifier<bool>(false);
  final isLoading = ValueNotifier<bool>(false);

  QuickAddMealState() {
    isInAddingMode.addListener(notifyListeners);
    isLoading.addListener(notifyListeners);
  }

  @override
  void dispose() {
    isInAddingMode.dispose();
    isLoading.dispose();
    super.dispose();
  }
}
