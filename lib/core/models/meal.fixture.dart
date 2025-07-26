import 'package:kali/core/models/Meal.model.dart';
import 'package:kali/core/models/MealPeriod.enum.dart';
import 'package:kali/core/models/nutriScore.fixture.dart';

final fixtureMeals = [
  fixtureMeal1,
  fixtureMeal2,
];

final fixtureMeal1 = MealModel(
  id: "0",
  date: DateTime.now(),
  userText: "100g Pizza",
  period: MealPeriodEnum.breakfast,
  nutriscore: fixtureNutriScore1,
);

final fixtureMeal2 = MealModel(
  id: "1",
  date: DateTime.now(),
  userText: "200g viande",
  period: MealPeriodEnum.lunch,
  nutriscore: fixtureNutriScore2,
);
