import 'package:flutter/material.dart';
import 'package:kali/core/models/Meal.model.dart';
import 'package:kali/core/models/MealPeriod.enum.dart';

final mealState = MealState();

class MealState extends ChangeNotifier {
  final currentMeal = ValueNotifier<MealModel?>(null);
  final currentMeals = ValueNotifier<List<MealModel>>([]);
  final currentDate = ValueNotifier<DateTime>(DateTime.now());
  final currentMealPeriods = ValueNotifier<List<MealPeriodEnum>>([]);

  MealState() {
    currentMeals.addListener(notifyListeners);
    currentMeal.addListener(notifyListeners);
    currentDate.addListener(notifyListeners);
    currentMealPeriods.addListener(notifyListeners);
  }

  @override
  void dispose() {
    currentMeals.dispose();
    currentMeal.dispose();
    currentDate.dispose();
    currentMealPeriods.dispose();
    super.dispose();
  }
}
