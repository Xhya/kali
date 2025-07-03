import 'package:kalori/client/states/startForm.state.dart';
import 'package:kalori/core/domains/nutriScore.service.dart';
import 'package:kalori/core/domains/nutriScore.state.dart';
import 'package:kalori/core/services/AI.service.dart';
import 'package:kalori/core/services/Error.service.dart';
import 'package:kalori/core/services/Navigation.service.dart';

onComputePersonalNutriScore() async {
  try {
    final personalNutriScore = await aiService.computePersonalNutriScore(
      size: startFormState.size.value,
      weight: startFormState.weight.value,
      age: startFormState.age.value,
    );
    nutriScoreState.personalNutriScore.value = personalNutriScore;
  } catch (e) {
    errorService.notifyError(e);
  }
}

onValidatePersonalNutriScore() async {
  try {
    if (nutriScoreState.personalNutriScore.value != null) {
      await setPersonalNutriScore(nutriScoreState.personalNutriScore.value!);
      nutriScoreState.personalNutriScore.value = null;
      navigationService.navigateTo(ScreenEnum.home);
    }
  } catch (e) {
    errorService.notifyError(e);
  }
}
