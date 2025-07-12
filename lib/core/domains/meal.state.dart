import 'package:flutter/material.dart';
import 'package:kali/core/models/Meal.model.dart';

var mealState = MealState();

class MealState extends ChangeNotifier {
  final currentMeal = ValueNotifier<MealModel?>(null);
  final currentMeals = ValueNotifier<List<MealModel>>([]);
  final currentDate = ValueNotifier<DateTime>(DateTime.now());

  MealState() {
    currentMeals.addListener(notifyListeners);
    currentMeal.addListener(notifyListeners);
    currentDate.addListener(notifyListeners);
  }

  @override
  void dispose() {
    currentMeals.dispose();
    currentMeal.dispose();
    currentDate.dispose();
    super.dispose();
  }
}
