import 'package:dart_date/dart_date.dart';
import 'package:kalori/core/domains/meal.repository.dart';
import 'package:kalori/core/models/Meal.model.dart';
import 'package:kalori/core/services/Error.service.dart';
import 'package:kalori/core/domains/meal.state.dart';

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
  } catch (e) {
    errorService.notifyError(e);
  }
}

addMeal(MealModel meal) async {
  try {
    await MealRepository().addMeal(meal);
    await refreshMeals();
  } catch (e) {
    errorService.notifyError(e);
  }
}
