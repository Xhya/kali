import 'package:dart_date/dart_date.dart';
import 'package:kali/core/domains/meal.repository.dart';
import 'package:kali/core/models/Meal.model.dart';
import 'package:kali/core/models/MealPeriod.enum.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/states/meal.state.dart';

refreshMeals() async {
  try {
    final List<MealModel> meals = await MealRepository().getMeals();
    mealState.currentMeals.value =
        meals
            .where(
              (it) =>
                  it.date != null
                      ? it.date!.isSameDay(mealState.currentDate.value)
                      : false,
            )
            .toList()
            .cast<MealModel>();
  } catch (e, stack) {
    errorService.notifyError(e: e, stack: stack);
  }
}

addMeal(String mealId, MealPeriodEnum period) async {
  try {
    await MealRepository().addMeal(mealId, period);
    await refreshMeals();
  } catch (e, stack) {
    errorService.notifyError(e: e, stack: stack);
  }
}

Future<MealModel?> computeMealNutriScore(String userText) async {
  return await MealRepository().computeMealNutriScore(userText);
}
