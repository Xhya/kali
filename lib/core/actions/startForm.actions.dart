import 'package:kali/core/domains/nutriScore.repository.dart';
import 'package:kali/core/domains/nutriScore.service.dart';
import 'package:kali/core/states/nutriScore.state.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/states/startForm.state.dart';

Future<void> computePersonalNutriScore() async {
  startFormState.isLoading.value = true;
  final personalNutriScore = await NutriScoreService()
      .computePersonalNutriScore(
        PersonalNutriScoreFormData(
          userName: startFormState.userName.value,
          leitmotiv: startFormState.leitmotiv.value,
          birthdate: startFormState.birthdate.value,
          gender: startFormState.genderOption.value?.label ?? "",
          size: startFormState.size.value,
          weight: startFormState.weight.value,
          targetWeight: startFormState.targetWeight.value,
          speedExpectation: startFormState.resultOption.value?.label ?? "",
          objective: startFormState.objectiveOption.value?.label ?? "",
          lifeRhythm: startFormState.lifeOption.value?.label ?? "",
        ),
      );
  nutriScoreState.personalNutriScore.value = personalNutriScore;
  startFormState.isLoading.value = false;
}

validatePersonalNutriScore() async {
  try {
    startFormState.isLoading.value = true;
    if (nutriScoreState.personalNutriScore.value != null) {
      await setPersonalNutriScore(nutriScoreState.personalNutriScore.value!);
    }
  } catch (e, stack) {
    errorService.notifyError(e: e, stack: stack);
  } finally {
    startFormState.isLoading.value = false;
  }
}
