import 'package:flutter_test/flutter_test.dart';
import 'package:kalori/client/states/quickAddMeal.state.dart';
import 'package:kalori/client/widgets/QuickAddMeal.widget.dart';
import 'package:kalori/core/actions/Goto.actions.dart';
import 'package:kalori/core/actions/nutriScore.actions.dart';
import 'package:kalori/core/domains/meal.state.dart';
import 'package:kalori/core/models/meal.fixture.dart';
import 'package:kalori/core/services/Navigation.service.dart';

void main() {
  setUp(() async {
    // todoItemData.reset();
    // await todoItemService.refreshTodoItems();
  });

  test('go to scenarios', () async {
    goToMealScreen(fixtureMeal1);
    expect(mealState.currentMeal.value, fixtureMeal1);
    expect(navigationService.currentScreen, ScreenEnum.meal);

    goToMealScreen(fixtureMeal1);
    expect(navigationService.currentScreen, ScreenEnum.meals);
  });
}
