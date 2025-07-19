import 'package:dart_date/dart_date.dart';
import 'package:kali/core/states/meal.state.dart';
import 'package:kali/core/models/Meal.model.dart';
import 'package:kali/core/models/MealPeriod.enum.dart';

Map<MealPeriodEnum, List<MealModel>> getDateMealsByPeriod(DateTime date) {
  final dateMeals = mealState.currentMeals.value.where((meal) {
    return meal.createdAt.isSameDay(date);
  });

  return {
    MealPeriodEnum.breakfast:
        dateMeals
            .where(
              (meal) =>
                  meal.period == MealPeriodEnum.breakfast &&
                  meal.nutriScore != null,
            )
            .toList(),
    MealPeriodEnum.lunch:
        dateMeals
            .where(
              (meal) =>
                  meal.period == MealPeriodEnum.lunch &&
                  meal.nutriScore != null,
            )
            .toList(),
    MealPeriodEnum.snack:
        dateMeals
            .where(
              (meal) =>
                  meal.period == MealPeriodEnum.snack &&
                  meal.nutriScore != null,
            )
            .toList(),
    MealPeriodEnum.dinner:
        dateMeals
            .where(
              (meal) =>
                  meal.period == MealPeriodEnum.dinner &&
                  meal.nutriScore != null,
            )
            .toList(),
  };
}
