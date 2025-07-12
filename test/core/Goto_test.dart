import 'package:flutter_test/flutter_test.dart';
import 'package:kali/client/states/quickAddMeal.state.dart';
import 'package:kali/client/widgets/QuickAddMeal.widget.dart';
import 'package:kali/core/actions/Goto.actions.dart';
import 'package:kali/core/actions/nutriScore.actions.dart';
import 'package:kali/core/domains/meal.state.dart';
import 'package:kali/core/models/meal.fixture.dart';
import 'package:kali/core/services/Navigation.service.dart';

void main() {
  setUp(() async {
    // todoItemData.reset();
    // await todoItemService.refreshTodoItems();
  });

  test('go to scenarios', () async {
    goToMealScreen(fixtureMeal1);
    expect(mealState.currentMeal.value, fixtureMeal1);
    expect(navigationService.currentScreen, ScreenEnum.meal);

    goToMealsScreen();
    expect(navigationService.currentScreen, ScreenEnum.meals);
  });
}
