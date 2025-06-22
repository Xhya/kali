import 'package:kalori/core/domains/meal.state.dart';
import 'package:kalori/core/domains/nutriScore.state.dart';
import 'package:kalori/core/models/NutriScore.model.dart';

void computeDayAverages() {
  if (nutriScoreState.currentNutriScore.value == null) {
    nutriScoreState.currentNutriScore.value = NutriScore(
      proteinAmount: 0.0,
      glucidAmount: 0.0,
      lipidAmount: 0.0,
      caloryAmount: 0.0,
    );
  }

  nutriScoreState.currentNutriScore.value!.lipidAmount = mealState
      .userMeals
      .value
      .fold(
        0,
        (sum, curr) => sum + (curr.nutriScore?.lipidAmount.toInt() ?? 0),
      );

  nutriScoreState.currentNutriScore.value!.proteinAmount = mealState
      .userMeals
      .value
      .fold(
        0,
        (sum, curr) => sum + (curr.nutriScore?.proteinAmount.toInt() ?? 0),
      );
  nutriScoreState.currentNutriScore.value!.glucidAmount = mealState
      .userMeals
      .value
      .fold(
        0,
        (sum, curr) => sum + (curr.nutriScore?.glucidAmount.toInt() ?? 0),
      );

  nutriScoreState.currentNutriScore.value!.caloryAmount = mealState
      .userMeals
      .value
      .fold(
        0,
        (sum, curr) => sum + (curr.nutriScore?.caloryAmount.toInt() ?? 0),
      );
}
