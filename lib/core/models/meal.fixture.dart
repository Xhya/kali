import 'package:kalori/core/models/Meal.model.dart';
import 'package:kalori/core/models/MealPeriod.enum.dart';
import 'package:kalori/core/models/nutriScore.fixture.dart';

final fixtureMeals = [
  fixtureMeal1,
];

final fixtureMeal1 = MealModel(
  id: "0",
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
  mealDescription: "100g Pizza",
  period: MealPeriodEnum.breakfast,
  nutriScore: fixtureNutriScore1,
);

final fixtureMeal2 = MealModel(
  id: "1",
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
  mealDescription: "200g viande",
  period: MealPeriodEnum.breakfast,
  nutriScore: fixtureNutriScore1,
);
