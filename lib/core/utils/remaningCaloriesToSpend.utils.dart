import 'package:kali/core/states/nutriScore.state.dart';
import 'package:kali/core/states/user.state.dart';

int? remaningCaloriesToSpend() {
  if (userState.personalNutriscore?.caloryAmount == null ||
      nutriScoreState.currentNutriScore.value?.caloryAmount == null) {
    return null;
  }
  return userState.personalNutriscore!.caloryAmount -
      nutriScoreState.currentNutriScore.value!.caloryAmount;
}
