import 'package:kali/core/states/nutriScore.state.dart';
import 'package:kali/core/states/user.state.dart';

int? computeRemainingCalories() {
  if (nutriScoreState.currentNutriScore.value != null &&
      userState.personalNutriscore != null) {
    return (userState.personalNutriscore.caloryAmount -
            nutriScoreState.currentNutriScore.value!.caloryAmount /
                userState.personalNutriscore.caloryAmount *
                100)
        .toInt();
  } else {
    return null;
  }
}
