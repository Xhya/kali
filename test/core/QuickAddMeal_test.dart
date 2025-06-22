import 'package:flutter_test/flutter_test.dart';
import 'package:kalori/client/states/quickAddMeal.state.dart';
import 'package:kalori/client/widgets/QuickAddMeal.widget.dart';
import 'package:kalori/core/actions/nutriScore.actions.dart';
import 'package:kalori/core/domains/meal.state.dart';
import 'package:kalori/core/models/meal.fixture.dart';

void main() {
  setUp(() async {
    // todoItemData.reset();
    // await todoItemService.refreshTodoItems();
  });

  test('quick add meal scenario', () async {
    expect(quickAddMealState.isInAddingMode.value, false);
    await initHomeScreen();
    expect(mealState.userMeals.value.length, 1);
    onOpenQuickAddMode();
    expect(quickAddMealState.isInAddingMode.value, true);
    onCloseQuickAddMode();
    expect(quickAddMealState.isInAddingMode.value, false);
    onOpenQuickAddMode();
    expect(quickAddMealState.isInAddingMode.value, true);
    onUpdateUserMealText("Pizza");
    expect(quickAddMealState.userMealText.value, "Pizza");
    onCloseQuickAddMode();
    expect(quickAddMealState.userMealText.value.isEmpty, true);
    onOpenQuickAddMode();
    expect(quickAddMealState.isInAddingMode.value, true);
    onUpdateUserMealText(fixtureMeal2.mealDescription);
    expect(quickAddMealState.userMealText.value, fixtureMeal2.mealDescription);
    await onAddMeal();
    expect(mealState.userMeals.value.length, 2);
    expect(mealState.userMeals.value.last.mealDescription, fixtureMeal2.mealDescription);
    expect(mealState.userMeals.value.last.nutriScore!.caloryAmount, fixtureMeal2.nutriScore!.caloryAmount);
    expect(mealState.userMeals.value.last.nutriScore!.glucidAmount, fixtureMeal2.nutriScore!.glucidAmount);
    expect(mealState.userMeals.value.last.nutriScore!.lipidAmount, fixtureMeal2.nutriScore!.lipidAmount);
    expect(mealState.userMeals.value.last.nutriScore!.proteinAmount, fixtureMeal2.nutriScore!.proteinAmount);
  });
}
