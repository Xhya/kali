import 'package:flutter/material.dart';
import 'package:kalori/core/models/MealPeriod.enum.dart';
import 'package:kalori/core/models/NutriScore.model.dart';

final editMealState = EditMealState();

class EditMealState extends ChangeNotifier {
  final isLoading = ValueNotifier<bool>(false);
  final editingNutriScore = ValueNotifier<NutriScore?>(null);
  final editingUserTextMeal = ValueNotifier<String>("");
  final editingMealPeriod = ValueNotifier<MealPeriodEnum?>(null);

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
