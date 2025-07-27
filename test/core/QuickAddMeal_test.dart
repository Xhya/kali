import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kali/client/screens/Home.screen.dart';
import 'package:kali/core/states/quickAddMeal.state.dart';
import 'package:kali/client/widgets/QuickAddMeal.widget.dart';
import 'package:kali/client/widgets/QuickAddMealHeader.widget.dart';
import 'package:kali/core/actions/nutriScore.actions.dart';
import 'package:kali/core/states/meal.state.dart';
import 'package:kali/core/states/nutriScore.state.dart';
import 'package:kali/core/models/meal.fixture.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/services/Translation.service.dart';

void main() {
  setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await TranslationService().init();
  });

  test('quick add meal scenario', () async {
    // expect(navigationService.bottomSheet, null);
    // await initHomeScreen();
    // expect(mealState.currentMeals.value.length, 2);
    // expect(navigationService.bottomSheet, isNotNull);
    // onClickCloseQuickAddMode();
    // expect(navigationService.bottomSheet, null);
    // expect(navigationService.bottomSheet, isNotNull);
    // onInputUpdateUserMealText("Pizza");
    // expect(quickAddMealState.userMealText.value, "Pizza");
    // onClickCloseQuickAddMode();
    // expect(quickAddMealState.userMealText.value.isEmpty, true);
    // expect(navigationService.bottomSheet, isNotNull);
    // onInputUpdateUserMealText(fixtureMeal2.userText!);
    // expect(quickAddMealState.userMealText.value, fixtureMeal2.userText);
    // await computeNutriScoreAction();
    // expect(nutriScoreState.currentNutriScore.value, isNotNull);
    // expect(
    //   nutriScoreState.currentNutriScore.value!.caloryAmount,
    //   fixtureMeal1.nutriscore!.caloryAmount + fixtureMeal2.nutriscore!.caloryAmount,
    // );
    // expect(
    //   nutriScoreState.currentNutriScore.value!.glucidAmount,
    //   fixtureMeal1.nutriscore!.glucidAmount + fixtureMeal2.nutriscore!.glucidAmount,
    // );
    // expect(
    //   nutriScoreState.currentNutriScore.value!.lipidAmount,
    //   fixtureMeal1.nutriscore!.lipidAmount + fixtureMeal2.nutriscore!.lipidAmount,
    // );
    // expect(
    //   nutriScoreState.currentNutriScore.value!.proteinAmount,
    //   fixtureMeal1.nutriscore!.proteinAmount + fixtureMeal2.nutriscore!.proteinAmount,
    // );
    // await onClickAddMealToDay();

    // expect(mealState.currentMeals.value.length, 1);
    // expect(mealState.currentMeals.value.last.userText, fixtureMeal2.userText);
    // expect(mealState.currentMeals.value.last.nutriScore!.caloryAmount, fixtureMeal2.nutriScore!.caloryAmount);
    // expect(mealState.currentMeals.value.last.nutriScore!.glucidAmount, fixtureMeal2.nutriScore!.glucidAmount);
    // expect(mealState.currentMeals.value.last.nutriScore!.lipidAmount, fixtureMeal2.nutriScore!.lipidAmount);
    // expect(mealState.currentMeals.value.last.nutriScore!.proteinAmount, fixtureMeal2.nutriScore!.proteinAmount);
  });
}
