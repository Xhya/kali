import 'package:flutter/material.dart';
import 'package:kali/core/models/MealPeriod.enum.dart';
import 'package:kali/core/models/NutriScore.model.dart';
import 'package:kali/core/states/meal.state.dart';

final editMealState = EditMealState();

class EditMealState extends ChangeNotifier {
  final isLoading = ValueNotifier<bool>(false);
  final editingNutriScore = ValueNotifier<NutriScore?>(null);
  final editingUserTextMeal = ValueNotifier<String>("");
  final editingMealPeriod = ValueNotifier<MealPeriodEnum?>(null);
  bool get canSave {
    final currentMeal = mealState.currentMeal.value;

    final hasDifference = editingMealPeriod.value != currentMeal?.period;

    return hasDifference;
  }

  EditMealState() {
    isLoading.addListener(notifyListeners);
    editingNutriScore.addListener(notifyListeners);
    editingUserTextMeal.addListener(notifyListeners);
    editingMealPeriod.addListener(notifyListeners);
  }

  @override
  void dispose() {
    isLoading.dispose();
    editingNutriScore.dispose();
    editingUserTextMeal.dispose();
    editingMealPeriod.dispose();
    super.dispose();
  }
}
