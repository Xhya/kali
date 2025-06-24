import 'package:flutter/material.dart';
import 'package:kalori/core/models/MealPeriod.enum.dart';

var quickAddMealState = QuickAddMealState();

class QuickAddMealState extends ChangeNotifier {
  final isLoading = ValueNotifier<bool>(false);
  final userMealText = ValueNotifier<String>("");
  final chosenPeriod = ValueNotifier<MealPeriodEnum?>(null);

  QuickAddMealState() {
    isLoading.addListener(notifyListeners);
    userMealText.addListener(notifyListeners);
  }

  @override
  void dispose() {
    isLoading.dispose();
    userMealText.dispose();
    super.dispose();
  }
}
