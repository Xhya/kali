import 'package:flutter_test/flutter_test.dart';
import 'package:kalori/client/screens/Home.screen.dart';
import 'package:kalori/client/states/quickAddMeal.state.dart';
import 'package:kalori/client/widgets/QuickAddMeal.widget.dart';
import 'package:kalori/core/actions/nutriScore.actions.dart';
import 'package:kalori/core/domains/meal.state.dart';
import 'package:kalori/core/models/meal.fixture.dart';
import 'package:kalori/core/services/Navigation.service.dart';

void main() {
  setUp(() async {
    // todoItemData.reset();
    // await todoItemService.refreshTodoItems();
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
    onInputUpdateUserMealText(fixtureMeal2.mealDescription);
    expect(quickAddMealState.userMealText.value, fixtureMeal2.mealDescription);
    await computeNutriScoreAction();
    // expect(mealState.currentMeals.value.length, 1);
    // expect(mealState.currentMeals.value.last.mealDescription, fixtureMeal2.mealDescription);
    // expect(mealState.currentMeals.value.last.nutriScore!.caloryAmount, fixtureMeal2.nutriScore!.caloryAmount);
    // expect(mealState.currentMeals.value.last.nutriScore!.glucidAmount, fixtureMeal2.nutriScore!.glucidAmount);
    // expect(mealState.currentMeals.value.last.nutriScore!.lipidAmount, fixtureMeal2.nutriScore!.lipidAmount);
    // expect(mealState.currentMeals.value.last.nutriScore!.proteinAmount, fixtureMeal2.nutriScore!.proteinAmount);
  });
}
