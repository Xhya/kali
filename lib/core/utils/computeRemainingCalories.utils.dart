import 'package:kali/core/states/nutriScore.state.dart';
import 'package:kali/core/states/user.state.dart';

int? computeRemainingCalories() {
  final nutriscore = nutriScoreState.currentNutriScore.value;
  final personalNutriscore = userState.personalNutriscore;

  if (nutriscore != null && personalNutriscore != null) {
    return (personalNutriscore.caloryAmount -
            nutriScoreState.currentNutriScore.value!.caloryAmount /
                personalNutriscore.caloryAmount *
                100)
        .toInt();
  } else {
    return null;
  }
}
