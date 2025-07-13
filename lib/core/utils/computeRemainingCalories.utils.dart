import 'package:kali/core/domains/nutriScore.state.dart';

int? computeRemainingCalories() {
  if (nutriScoreState.currentNutriScore.value != null &&
      nutriScoreState.personalNutriScore.value != null) {
    return (nutriScoreState.personalNutriScore.value!.caloryAmount -
        nutriScoreState.currentNutriScore.value!.caloryAmount /
            nutriScoreState.personalNutriScore.value!.caloryAmount *
            100).toInt();
  } else {
    return null;
  }
}
