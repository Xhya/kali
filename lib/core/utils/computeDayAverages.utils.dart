import 'package:kali/core/models/Meal.model.dart';
import 'package:kali/core/models/NutriScore.model.dart';

NutriScore computeDayAverages(List<MealModel> meals) {
  final lipidAmount = meals.fold(
    0,
    (sum, curr) => sum + (curr.nutriscore?.lipidAmount.toInt() ?? 0),
  );
  final proteinAmount = meals.fold(
    0,
    (sum, curr) => sum + (curr.nutriscore?.proteinAmount.toInt() ?? 0),
  );

  final glucidAmount = meals.fold(
    0,
    (sum, curr) => sum + (curr.nutriscore?.glucidAmount.toInt() ?? 0),
  );

  final caloryAmount = meals.fold(
    0,
    (sum, curr) => sum + (curr.nutriscore?.caloryAmount.toInt() ?? 0),
  );

  return NutriScore(
    proteinAmount: proteinAmount,
    glucidAmount: glucidAmount,
    lipidAmount: lipidAmount,
    caloryAmount: caloryAmount,
  );
}
