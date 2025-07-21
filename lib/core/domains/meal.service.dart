import 'package:dart_date/dart_date.dart';
import 'package:kali/core/domains/meal.repository.dart';
import 'package:kali/core/models/Meal.model.dart';
import 'package:kali/core/models/NutriScore.model.dart';
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

addMeal(MealModel meal) async {
  try {
    await MealRepository().addMeal(meal);
    await refreshMeals();
  } catch (e, stack) {
    errorService.notifyError(e: e, stack: stack);
  }
}

Future<NutriScore?> computeNutriScore(String userText) async {
  return await MealRepository().computeNutriScore(userText);
}
