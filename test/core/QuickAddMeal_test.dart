import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kali/client/screens/Home.screen.dart';
import 'package:kali/client/states/quickAddMeal.state.dart';
import 'package:kali/client/widgets/QuickAddMeal.widget.dart';
import 'package:kali/core/actions/nutriScore.actions.dart';
import 'package:kali/core/domains/meal.state.dart';
import 'package:kali/core/domains/nutriScore.state.dart';
import 'package:kali/core/models/meal.fixture.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/services/Translation.service.dart';

void main() {
  setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await TranslationService().init();
  });

  test('quick add meal scenario', () async {
    expect(navigationService.bottomSheet, null);
    await initHomeScreen();
    expect(mealState.currentMeals.value.length, 1);
    onClickPeriodToQuickAddMeal();
    expect(navigationService.bottomSheet, isNotNull);
    onClickCloseQuickAddMode();
    expect(navigationService.bottomSheet, null);
    onClickPeriodToQuickAddMeal();
    expect(navigationService.bottomSheet, isNotNull);
    onInputUpdateUserMealText("Pizza");
    expect(quickAddMealState.userMealText.value, "Pizza");
    onClickCloseQuickAddMode();
    expect(quickAddMealState.userMealText.value.isEmpty, true);
    onClickPeriodToQuickAddMeal();
    expect(navigationService.bottomSheet, isNotNull);
    onInputUpdateUserMealText(fixtureMeal2.mealDescription!);
    expect(quickAddMealState.userMealText.value, fixtureMeal2.mealDescription);
    await computeNutriScoreAction();
    expect(nutriScoreState.currentNutriScore.value, isNotNull);
    expect(
      nutriScoreState.currentNutriScore.value!.caloryAmount,
      fixtureMeal1.nutriScore!.caloryAmount,
    );
    expect(
      nutriScoreState.currentNutriScore.value!.glucidAmount,
      fixtureMeal1.nutriScore!.glucidAmount,
    );
    expect(
      nutriScoreState.currentNutriScore.value!.lipidAmount,
      fixtureMeal1.nutriScore!.lipidAmount,
    );
    expect(
      nutriScoreState.currentNutriScore.value!.proteinAmount,
      fixtureMeal1.nutriScore!.proteinAmount,
    );
    await onClickAddMealToDay();

    // expect(mealState.currentMeals.value.length, 1);
    // expect(mealState.currentMeals.value.last.mealDescription, fixtureMeal2.mealDescription);
    // expect(mealState.currentMeals.value.last.nutriScore!.caloryAmount, fixtureMeal2.nutriScore!.caloryAmount);
    // expect(mealState.currentMeals.value.last.nutriScore!.glucidAmount, fixtureMeal2.nutriScore!.glucidAmount);
    // expect(mealState.currentMeals.value.last.nutriScore!.lipidAmount, fixtureMeal2.nutriScore!.lipidAmount);
    // expect(mealState.currentMeals.value.last.nutriScore!.proteinAmount, fixtureMeal2.nutriScore!.proteinAmount);
  });
}
