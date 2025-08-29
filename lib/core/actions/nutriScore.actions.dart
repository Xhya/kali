import 'package:kali/core/states/Ai.state.dart';
import 'package:kali/core/states/quickAddMeal.state.dart';
import 'package:kali/core/domains/meal.service.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/utils/computeMealPeriod.utils.dart';

Future<void> computeNutriScoreAction() async {
  try {
    quickAddMealState.isLoading.value = true;
    final userText = quickAddMealState.userMealText.value;

    final meal = await MealService().computeMealNutriScore(userText);
    quickAddMealState.meal.value = meal;
    quickAddMealState.isLoading.value = false;
    quickAddMealState.computed.value = true;
  } catch (e, stack) {
    errorService.notifyError(
      e: e,
      stack: stack,
      show: !aiState.aiNotUnderstandError.value,
    );
  } finally {
    quickAddMealState.isLoading.value = false;
  }
}

Future<void> addMealAction() async {
  try {
    final period =
        quickAddMealState.chosenPeriod.value ??
        computeMealPeriod(DateTime.now());
    final meal = quickAddMealState.meal.value;

    if (meal != null) {
      await MealService().updateMeal(
        mealId: meal.id,
        period: period,
        date: quickAddMealState.date.value,
      );
    }
  } catch (e, stack) {
    errorService.notifyError(e: e, stack: stack);
  } finally {
    quickAddMealState.isLoading.value = false;
  }
}
