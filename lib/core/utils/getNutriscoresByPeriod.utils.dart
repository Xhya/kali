import 'package:kali/core/models/Meal.model.dart';
import 'package:kali/core/models/MealPeriod.enum.dart';
import 'package:kali/core/models/NutriScore.model.dart';

Map<MealPeriodEnum, List<NutriScore>> getNutriscoresByPeriod(
  List<MealModel> meals,
) {
  final List<NutriScore> breakfastNutriscoresByPeriod =
      meals
          .where((it) => it.period == MealPeriodEnum.breakfast)
          .map((it) => it.nutriscore!)
          .toList();

  final List<NutriScore> lunchNutriscoresByPeriod =
      meals
          .where((it) => it.period == MealPeriodEnum.lunch)
          .map((it) => it.nutriscore!)
          .toList();

  final List<NutriScore> snackNutriscoresByPeriod =
      meals
          .where((it) => it.period == MealPeriodEnum.snack)
          .map((it) => it.nutriscore!)
          .toList();

  final List<NutriScore> dinnerNutriscoresByPeriod =
      meals
          .where((it) => it.period == MealPeriodEnum.dinner)
          .map((it) => it.nutriscore!)
          .toList();

  return {
    MealPeriodEnum.breakfast: breakfastNutriscoresByPeriod,
    MealPeriodEnum.lunch: lunchNutriscoresByPeriod,
    MealPeriodEnum.snack: snackNutriscoresByPeriod,
    MealPeriodEnum.dinner: dinnerNutriscoresByPeriod,
  };
}
