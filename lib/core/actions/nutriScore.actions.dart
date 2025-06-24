import 'package:kalori/client/states/quickAddMeal.state.dart';
import 'package:kalori/core/domains/meal.service.dart';
import 'package:kalori/core/models/nutriScore.fixture.dart';
import 'package:kalori/core/utils/computeDayAverages.utils.dart';
import 'package:kalori/core/domains/nutriScore.service.dart';
import 'package:kalori/core/services/Error.service.dart';

initHomeScreen() async {
  try {
    await refreshMeals();
    computeDayAverages();
    await refreshPersonalNutriScore();
  } catch (e) {
    errorService.notifyError(e);
  }
}

addMealAction() async {
  try {
    quickAddMealState.isLoading.value = true;
    final userText = quickAddMealState.userMealText.value;
    // final nutriScore = await aiService.computeNutriScore(userText);
    quickAddMealState.nutriScore.value = fixtureNutriScore1;
    quickAddMealState.isLoading.value = false;

    // final period =
    //     quickAddMealState.chosenPeriod.value ??
    //     computeMealPeriod(DateTime.now());
    // final meal = MealModel(
    //   id: Uuid().v6(),
    //   createdAt: DateTime.now(),
    //   updatedAt: DateTime.now(),
    //   mealDescription: userText,
    //   period: period,
    //   nutriScore: nutriScore,
    // );
    // await addMeal(meal);
    // computeDayAverages();
    // quickAddMealState.isLoading.value = false;
    // quickAddMealState.userMealText.value = "";
    // navigationService.closeBottomSheet();
  } catch (e) {
    quickAddMealState.isLoading.value = false;
    errorService.notifyError(e);
  }
}
