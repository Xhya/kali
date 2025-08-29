import 'package:flutter/material.dart';
import 'package:kali/core/models/Meal.model.dart';
import 'package:kali/core/models/MealPeriod.enum.dart';
import 'package:kali/core/states/Ai.state.dart';

final quickAddMealState = QuickAddMealState();

class QuickAddMealState extends ChangeNotifier {
  final isLoading = ValueNotifier<bool>(false);
  final computed = ValueNotifier<bool>(false);
  final userMealText = ValueNotifier<String>("");
  final chosenPeriod = ValueNotifier<MealPeriodEnum?>(null);
  final meal = ValueNotifier<MealModel?>(null);
  final isExpanded = ValueNotifier<bool>(false);
  final date = ValueNotifier<DateTime>(DateTime.now());

  QuickAddMealState() {
    isLoading.addListener(notifyListeners);
    userMealText.addListener(notifyListeners);
    chosenPeriod.addListener(notifyListeners);
    meal.addListener(notifyListeners);
    isExpanded.addListener(notifyListeners);
    date.addListener(notifyListeners);
  }

  @override
  void dispose() {
    isLoading.dispose();
    userMealText.dispose();
    chosenPeriod.dispose();
    meal.dispose();
    isExpanded.dispose();
    date.dispose();
    super.dispose();
  }

  reset() {
    isLoading.value = false;
    userMealText.value = "";
    chosenPeriod.value = null;
    meal.value = null;
    isExpanded.value = false;
    aiState.aiNotUnderstandError.value = false;
  }
}
