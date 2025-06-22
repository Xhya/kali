import 'package:kalori/core/domains/meal.repository.dart';
import 'package:kalori/core/models/Meal.model.dart';
import 'package:kalori/core/services/Error.service.dart';
import 'package:kalori/core/domains/meal.state.dart';

refreshMeals() async {
  try {
    final list = await MealRepository().getMeals();
    mealState.userMeals.value = List.from(list);
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
