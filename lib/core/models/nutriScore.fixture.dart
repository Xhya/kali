import 'package:kalori/core/models/MealPeriod.enum.dart';
import 'package:kalori/core/models/NutriScore.model.dart';

final fixtureNutriScores = [
  fixtureNutriScore1,
];

final fixtureNutriScore1 = NutriScore(
  id: "0",
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
  mealDescription: "100g Pizza",
  period: MealPeriodEnum.breakfast,
  proteinAmount: 30,
  lipidAmount: 20,
  glucidAmount: 50,
);
