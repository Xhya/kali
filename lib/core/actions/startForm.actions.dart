import 'package:kali/client/states/startForm.state.dart';
import 'package:kali/core/domains/nutriScore.service.dart';
import 'package:kali/core/domains/nutriScore.state.dart';
import 'package:kali/core/services/AI.service.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/Navigation.service.dart';

onComputePersonalNutriScore() async {
  try {
    final personalNutriScore = await aiService.computePersonalNutriScore(
      size: startFormState.size.value,
      weight: startFormState.weight.value,
      age: startFormState.age.value,
    );
    nutriScoreState.personalNutriScore.value = personalNutriScore;
  } catch (e, stack) {
    errorService.notifyError(e: e, stack: stack);
  }
}

onValidatePersonalNutriScore() async {
  try {
    if (nutriScoreState.personalNutriScore.value != null) {
      await setPersonalNutriScore(nutriScoreState.personalNutriScore.value!);
      nutriScoreState.personalNutriScore.value = null;
      navigationService.navigateTo(ScreenEnum.home);
    }
  } catch (e, stack) {
    errorService.notifyError(e: e, stack: stack);
  }
}
