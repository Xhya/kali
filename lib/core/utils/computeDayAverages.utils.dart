import 'package:kali/core/states/meal.state.dart';
import 'package:kali/core/states/nutriScore.state.dart';
import 'package:kali/core/models/NutriScore.model.dart';

void computeDayAverages() {
  if (nutriScoreState.currentNutriScore.value == null) {
    nutriScoreState.currentNutriScore.value = NutriScore(
      proteinAmount: 0,
      glucidAmount: 0,
      lipidAmount: 0,
      caloryAmount: 0,
    );
  }

  nutriScoreState.currentNutriScore.value!.lipidAmount = mealState
      .currentMeals
      .value
      .fold(
        0,
        (sum, curr) => sum + (curr.nutriScore?.lipidAmount.toInt() ?? 0),
      );

  nutriScoreState.currentNutriScore.value!.proteinAmount = mealState
      .currentMeals
      .value
      .fold(
        0,
        (sum, curr) => sum + (curr.nutriScore?.proteinAmount.toInt() ?? 0),
      );
  nutriScoreState.currentNutriScore.value!.glucidAmount = mealState
      .currentMeals
      .value
      .fold(
        0,
        (sum, curr) => sum + (curr.nutriScore?.glucidAmount.toInt() ?? 0),
      );

  nutriScoreState.currentNutriScore.value!.caloryAmount = mealState
      .currentMeals
      .value
      .fold(
        0,
        (sum, curr) => sum + (curr.nutriScore?.caloryAmount.toInt() ?? 0),
      );
}
