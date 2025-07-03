import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kalori/client/screens/StartForm.screen.dart';
import 'package:kalori/client/states/startForm.state.dart';
import 'package:kalori/core/domains/nutriScore.state.dart';
import 'package:kalori/core/models/meal.fixture.dart';
import 'package:kalori/core/services/Navigation.service.dart';
import 'package:kalori/core/services/Translation.service.dart';

void main() {
  setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await TranslationService().init();
  });

  test('start form scenario', () async {
    expect(nutriScoreState.personalNutriScore.value, null);
    expect(startFormState.isSubmitButtonDisabled, true);
    var text = getSubmitButtonText();
    expect(text, t('compute'));
    onUpdateSize("170");
    expect(startFormState.isSubmitButtonDisabled, true);
    onUpdateWeight("81");
    expect(startFormState.isSubmitButtonDisabled, true);
    onUpdateAge("37");
    expect(startFormState.isSubmitButtonDisabled, false);
    await onClickSubmitButton();
    expect(nutriScoreState.personalNutriScore.value, isNotNull);
    expect(
      nutriScoreState.personalNutriScore.value!.caloryAmount,
      fixtureMeal2.nutriScore!.caloryAmount,
    );
    expect(
      nutriScoreState.personalNutriScore.value!.glucidAmount,
      fixtureMeal2.nutriScore!.glucidAmount,
    );
    expect(
      nutriScoreState.personalNutriScore.value!.proteinAmount,
      fixtureMeal2.nutriScore!.proteinAmount,
    );
    expect(
      nutriScoreState.personalNutriScore.value!.lipidAmount,
      fixtureMeal2.nutriScore!.lipidAmount,
    );
    text = getSubmitButtonText();
    expect(text, t('validate'));
    await onClickSubmitButton();
    expect(nutriScoreState.personalNutriScore.value, null);
    expect(navigationService.currentScreen, ScreenEnum.home);
  });
}
