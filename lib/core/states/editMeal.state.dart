import 'package:flutter/material.dart';
import 'package:kali/core/models/MealPeriod.enum.dart';
import 'package:kali/core/models/NutriScore.model.dart';
import 'package:kali/core/states/meal.state.dart';

final editMealState = EditMealState();

class EditMealState extends ChangeNotifier {
  final isComputeLoading = ValueNotifier<bool>(false);
  final isRegisterLoading = ValueNotifier<bool>(false);
  final editingNutriScore = ValueNotifier<NutriScore?>(null);
  final editingUserTextMeal = ValueNotifier<String>("");
  final editingMealPeriod = ValueNotifier<MealPeriodEnum?>(null);
  bool get canSave {
    final currentMeal = mealState.currentMeal.value;

    final hasDifference =
        editingMealPeriod.value != currentMeal?.period ||
        editingNutriScore.value != null;

    return hasDifference;
  }

  bool get canCompute {
    final currentMeal = mealState.currentMeal.value;
    return editingUserTextMeal.value != currentMeal?.nutriscore?.userText &&
        editingNutriScore.value == null;
  }

  EditMealState() {
    isComputeLoading.addListener(notifyListeners);
    isRegisterLoading.addListener(notifyListeners);
    editingNutriScore.addListener(notifyListeners);
    editingUserTextMeal.addListener(notifyListeners);
    editingMealPeriod.addListener(notifyListeners);
  }

  @override
  void dispose() {
    isComputeLoading.dispose();
    isRegisterLoading.dispose();
    editingNutriScore.dispose();
    editingUserTextMeal.dispose();
    editingMealPeriod.dispose();
    super.dispose();
  }
}
