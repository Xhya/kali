import 'package:kali/core/states/nutriScore.state.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/states/user.state.dart';

double? computeNutriScoreAverage(String macroType) {
  if (macroType == "glucids") {
    if (nutriScoreState.currentNutriScore.value != null &&
        userState.personalNutriscore != null) {
      return nutriScoreState.currentNutriScore.value!.glucidAmount /
          userState.personalNutriscore.glucidAmount *
          100;
    } else {
      errorService.notifyError(e: Exception("Missing nutriscores"));
    }
  }

  if (macroType == "lipids") {
    if (nutriScoreState.currentNutriScore.value != null &&
        userState.personalNutriscore != null) {
      return nutriScoreState.currentNutriScore.value!.lipidAmount /
          userState.personalNutriscore.lipidAmount *
          100;
    } else {
      errorService.notifyError(e: Exception("Missing nutriscores"));
    }
  }

  if (macroType == "proteins") {
    if (nutriScoreState.currentNutriScore.value != null &&
        userState.personalNutriscore != null) {
      return nutriScoreState.currentNutriScore.value!.proteinAmount /
          userState.personalNutriscore.proteinAmount *
          100;
    } else {
      errorService.notifyError(e: Exception("Missing nutriscores"));
    }
  }
}
