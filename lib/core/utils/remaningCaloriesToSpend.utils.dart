import 'package:kalori/core/domains/nutriScore.state.dart';
import 'package:kalori/core/services/Error.service.dart';

int remaningCaloriesToSpend() {
  if (nutriScoreState.personalNutriScore.value?.caloryAmount == null ||
      nutriScoreState.currentNutriScore.value?.caloryAmount == null) {
    errorService.notifyError("Missing data");
    throw Error();
  }
  return nutriScoreState.personalNutriScore.value!.caloryAmount -
      nutriScoreState.currentNutriScore.value!.caloryAmount;
}
