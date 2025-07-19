import 'package:kali/core/states/nutriScore.state.dart';
import 'package:kali/core/services/Error.service.dart';

double? computeNutriScoreAverage(String macroType) {
  if (macroType == "glucids") {
    if (nutriScoreState.currentNutriScore.value != null &&
        nutriScoreState.personalNutriScore.value != null) {
      return nutriScoreState.currentNutriScore.value!.glucidAmount /
          nutriScoreState.personalNutriScore.value!.glucidAmount *
          100;
    } else {
      errorService.notifyError(e: "Missing nutriscores");
    }
  }

  if (macroType == "lipids") {
    if (nutriScoreState.currentNutriScore.value != null &&
        nutriScoreState.personalNutriScore.value != null) {
      return nutriScoreState.currentNutriScore.value!.lipidAmount /
          nutriScoreState.personalNutriScore.value!.lipidAmount *
          100;
    } else {
      errorService.notifyError(e: "Missing nutriscores");
    }
  }

  if (macroType == "proteins") {
    if (nutriScoreState.currentNutriScore.value != null &&
        nutriScoreState.personalNutriScore.value != null) {
      return nutriScoreState.currentNutriScore.value!.proteinAmount /
          nutriScoreState.personalNutriScore.value!.proteinAmount *
          100;
    } else {
      errorService.notifyError(e: "Missing nutriscores");
    }
  }
}
