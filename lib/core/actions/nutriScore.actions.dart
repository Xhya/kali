import 'package:kalori/client/states/quickAddMeal.state.dart';
import 'package:kalori/core/domains/meal.service.dart';
import 'package:kalori/core/domains/nutriScore.service.dart';
import 'package:kalori/core/models/Meal.model.dart';
import 'package:kalori/core/services/Error.service.dart';
import 'package:kalori/core/utils/computeMealPeriod.utils.dart';
import 'package:uuid/uuid.dart';

initHomeScreen() async {
  try {
    await refreshMeals();
  } catch (e) {
    errorService.notifyError(e);
  }
}

onAddMeal() async {
  try {
    final userText = quickAddMealState.userMealText.value;
    final nutriScore = await computeNutriScore(userText);
    final meal = MealModel(
      id: Uuid().v6(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      mealDescription: userText,
      period: computeMealPeriod(DateTime.now()),
      nutriScore: nutriScore,
    );
    await addMeal(meal);
    quickAddMealState.isLoading.value = false;
    quickAddMealState.userMealText.value = "";
    quickAddMealState.isInAddingMode.value = false;
  } catch (e) {
    quickAddMealState.isLoading.value = false;
    errorService.notifyError(e);
  }
}



