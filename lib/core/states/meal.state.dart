import 'package:flutter/material.dart';
import 'package:kali/core/models/Meal.model.dart';
import 'package:kali/core/models/MealPeriod.enum.dart';
import 'package:kali/core/models/NutriScore.model.dart';
import 'package:kali/core/states/user.state.dart';
import 'package:kali/core/utils/computeDayAverages.utils.dart';
import 'package:kali/core/utils/computeRemainingCalories.utils.dart';

final mealState = MealState();

class MealState extends ChangeNotifier {
  final isLoadingDate = ValueNotifier<bool>(false);
  final currentMeal = ValueNotifier<MealModel?>(null);
  final currentMeals = ValueNotifier<List<MealModel>>([]);
  NutriScore get mealsNutriScore => computeDayAverages(currentMealsByPeriods);
  int get remainingCalories =>
      computeRemainingCalories(mealsNutriScore, userState.personalNutriscore);

  List<MealModel> get currentMealsByPeriods =>
      currentMeals.value.where((it) {
        if (currentMealPeriods.value.isEmpty) {
          return true;
        } else {
          return currentMealPeriods.value.contains(it.period);
        }
      }).toList();

  final currentDate = ValueNotifier<DateTime>(DateTime.now());
  final currentMealPeriods = ValueNotifier<List<MealPeriodEnum>>([]);

  MealState() {
    isLoadingDate.addListener(notifyListeners);
    currentMeals.addListener(notifyListeners);
    currentMeal.addListener(notifyListeners);
    currentDate.addListener(notifyListeners);
    currentMealPeriods.addListener(notifyListeners);
  }

  @override
  void dispose() {
    isLoadingDate.dispose();
    currentMeals.dispose();
    currentMeal.dispose();
    currentDate.dispose();
    currentMealPeriods.dispose();
    super.dispose();
  }
}
