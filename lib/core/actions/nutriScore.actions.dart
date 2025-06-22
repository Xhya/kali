import 'package:kalori/client/states/quickAddMeal.state.dart';
import 'package:kalori/core/domains/meal.repository.dart';
import 'package:kalori/core/domains/meal.state.dart';
import 'package:kalori/core/models/Meal.model.dart';
import 'package:kalori/core/services/AI.service.dart';
import 'package:kalori/core/services/Error.service.dart';
import 'package:kalori/core/utils/computeMealPeriod.utils.dart';
import 'package:uuid/uuid.dart';

initHomeScreen() async {
  try {
    await _refreshMeals();
  } catch (e) {
    errorService.notifyError(e);
  }
}

_refreshMeals() async {
  try {
    final list = await MealRepository().getMeals();
    mealState.userMeals.value = List.from(list);
  } catch (e) {
    errorService.notifyError(e);
  }
}

computeNutriScore(String userText) async {
  try {
    quickAddMealState.isLoading.value = true;
    final nutriScore = await aiService.computeNutriScore(userText);
    final meal = MealModel(
      id: Uuid().v6(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      mealDescription: userText,
      period: computeMealPeriod(DateTime.now()),
      nutriScore: nutriScore,
    );
    await _addNutriScore(meal);
    // nutriScoreState.currentNutriScore.value = nutriScore;
    quickAddMealState.isLoading.value = false;
    quickAddMealState.userMealText.value = "";
    quickAddMealState.isInAddingMode.value = false;
  } catch (e) {
    quickAddMealState.isLoading.value = false;
    errorService.notifyError(e);
  }
}

_addNutriScore(MealModel meal) async {
  try {
    await MealRepository().addMeal(meal);
    await _refreshMeals();
  } catch (e) {
    errorService.notifyError(e);
  }
}
