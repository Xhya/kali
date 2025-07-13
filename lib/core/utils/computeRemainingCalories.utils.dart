import 'dart:ffi';

import 'package:kali/core/domains/nutriScore.state.dart';
import 'package:kali/core/services/Error.service.dart';

int? computeRemainingCalories(String macroType) {
  if (nutriScoreState.currentNutriScore.value != null &&
      nutriScoreState.personalNutriScore.value != null) {
    return (nutriScoreState.personalNutriScore.value!.caloryAmount -
        nutriScoreState.currentNutriScore.value!.caloryAmount /
            nutriScoreState.personalNutriScore.value!.caloryAmount *
            100).toInt();
  } else {
    errorService.notifyError(e: "Missing nutriscores");
    return null;
  }
}
