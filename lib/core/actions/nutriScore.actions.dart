import 'package:kali/core/domains/nutriscore.service.dart';
import 'package:kali/core/states/Ai.state.dart';
import 'package:kali/core/states/quickAddMeal.state.dart';
import 'package:kali/core/domains/meal.service.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/utils/computeMealPeriod.utils.dart';

Future<void> computeNutriScoreAction() async {
  try {
    quickAddMealState.isComputingLoading.value = true;
    final userText = quickAddMealState.userMealText.value;

    final meal = await nutriscoreService.computeNutriScore(userText: userText);
    quickAddMealState.nutriscore.value = meal;
    quickAddMealState.isComputingLoading.value = false;
    quickAddMealState.computed.value = true;
  } catch (e, stack) {
    errorService.notifyError(
      e: e,
      stack: stack,
      show: !aiState.aiNotUnderstandError.value,
    );
  } finally {
    quickAddMealState.isComputingLoading.value = false;
  }
}

Future<void> addMealAction() async {
  try {
    final period =
        quickAddMealState.chosenPeriod.value ??
        computeMealPeriod(DateTime.now());

    if (quickAddMealState.nutriscore.value?.id != null) {
      await MealService().createMeal(
        period: period,
        date: quickAddMealState.date.value,
        nutriscoreId: quickAddMealState.nutriscore.value!.id!,
      );
    }
  } catch (e, stack) {
    errorService.notifyError(e: e, stack: stack);
  } finally {
    quickAddMealState.isComputingLoading.value = false;
  }
}
