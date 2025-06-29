import 'package:flutter/material.dart';
import 'package:kalori/core/models/Meal.model.dart';

var mealState = MealState();

class MealState extends ChangeNotifier {
  final currentMeal = ValueNotifier<MealModel?>(null);
  final currentMeals = ValueNotifier<List<MealModel>>([]);

  MealState() {
    currentMeals.addListener(notifyListeners);
  }

  @override
  void dispose() {
    currentMeals.dispose();
    super.dispose();
  }
}
