import 'package:kalori/core/domains/nutriScore.state.dart';

int? remaningCaloriesToSpend() {
  if (nutriScoreState.personalNutriScore.value?.caloryAmount == null ||
      nutriScoreState.currentNutriScore.value?.caloryAmount == null) {
    return null;
  }
  return nutriScoreState.personalNutriScore.value!.caloryAmount -
      nutriScoreState.currentNutriScore.value!.caloryAmount;
}
