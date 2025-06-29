import 'package:kalori/core/models/Meal.model.dart';
import 'package:kalori/core/models/MealPeriod.enum.dart';
import 'package:kalori/core/models/NutriScore.model.dart';
import 'package:kalori/core/models/nutriScore.fixture.dart';
import 'package:kalori/core/utils/getNutriscoresByPeriod.utils.dart';

Map<MealPeriodEnum, NutriScore> getTotalNutriscoreByPeriod(
  List<MealModel> meals,
) {
  final nutriscoresByPeriod = getNutriscoresByPeriod(meals);

  final NutriScore breakfastNutriscoreByPeriod =
      (nutriscoresByPeriod[MealPeriodEnum.breakfast] ?? []).fold(
        emptyNutriScore,
        (prev, curr) {
          return NutriScore(
            proteinAmount: prev.proteinAmount + curr.proteinAmount,
            glucidAmount: prev.glucidAmount + curr.glucidAmount,
            lipidAmount: prev.lipidAmount + curr.lipidAmount,
            caloryAmount: prev.caloryAmount + curr.caloryAmount,
          );
        },
      );

  final NutriScore lunchNutriscoreByPeriod =
      (nutriscoresByPeriod[MealPeriodEnum.lunch] ?? []).fold(emptyNutriScore, (
        prev,
        curr,
      ) {
        return NutriScore(
          proteinAmount: prev.proteinAmount + curr.proteinAmount,
          glucidAmount: prev.glucidAmount + curr.glucidAmount,
          lipidAmount: prev.lipidAmount + curr.lipidAmount,
          caloryAmount: prev.caloryAmount + curr.caloryAmount,
        );
      });

  final NutriScore snackNutriscoreByPeriod =
      (nutriscoresByPeriod[MealPeriodEnum.snack] ?? []).fold(emptyNutriScore, (
        prev,
        curr,
      ) {
        return NutriScore(
          proteinAmount: prev.proteinAmount + curr.proteinAmount,
          glucidAmount: prev.glucidAmount + curr.glucidAmount,
          lipidAmount: prev.lipidAmount + curr.lipidAmount,
          caloryAmount: prev.caloryAmount + curr.caloryAmount,
        );
      });

  final NutriScore dinnerNutriscoreByPeriod =
      (nutriscoresByPeriod[MealPeriodEnum.dinner] ?? []).fold(emptyNutriScore, (
        prev,
        curr,
      ) {
        return NutriScore(
          proteinAmount: prev.proteinAmount + curr.proteinAmount,
          glucidAmount: prev.glucidAmount + curr.glucidAmount,
          lipidAmount: prev.lipidAmount + curr.lipidAmount,
          caloryAmount: prev.caloryAmount + curr.caloryAmount,
        );
      });

  return {
    MealPeriodEnum.breakfast: breakfastNutriscoreByPeriod,
    MealPeriodEnum.lunch: lunchNutriscoreByPeriod,
    MealPeriodEnum.snack: snackNutriscoreByPeriod,
    MealPeriodEnum.dinner: dinnerNutriscoreByPeriod,
  };
}
