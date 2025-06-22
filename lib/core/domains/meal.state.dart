import 'package:flutter/material.dart';
import 'package:kalori/core/models/Meal.model.dart';

var mealState = MealState();

class MealState extends ChangeNotifier {
  final currentMeal = ValueNotifier<MealModel?>(null);
  final userMeals = ValueNotifier<List<MealModel>>([]);

  MealState() {
    userMeals.addListener(notifyListeners);
  }

  @override
  void dispose() {
    userMeals.dispose();
    super.dispose();
  }
}
