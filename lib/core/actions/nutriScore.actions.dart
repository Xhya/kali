import 'package:kalori/client/states/quickAddMeal.state.dart';
import 'package:kalori/core/domains/meal.service.dart';
import 'package:kalori/core/models/Meal.model.dart';
import 'package:kalori/core/models/nutriScore.fixture.dart';
import 'package:kalori/core/services/AI.service.dart';
import 'package:kalori/core/services/Navigation.service.dart';
import 'package:kalori/core/utils/computeDayAverages.utils.dart';
import 'package:kalori/core/domains/nutriScore.service.dart';
import 'package:kalori/core/services/Error.service.dart';
import 'package:kalori/core/utils/computeMealPeriod.utils.dart';
import 'package:uuid/uuid.dart';

computeNutriScoreAction() async {
  try {
    quickAddMealState.isLoading.value = true;
    final userText = quickAddMealState.userMealText.value;
    //final nutriScore = await aiService.computeNutriScore(userText);
    quickAddMealState.nutriScore.value = fixtureNutriScore1;
    quickAddMealState.isLoading.value = false;
  } catch (e) {
    print("ERROR TOTO");
    errorService.notifyError(e);
  } finally {
    quickAddMealState.isLoading.value = false;
  }
}

addMealAction() async {
  try {
    final userText = quickAddMealState.userMealText.value;
    final period =
        quickAddMealState.chosenPeriod.value ??
        computeMealPeriod(DateTime.now());
    final meal = MealModel(
      id: Uuid().v6(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      mealDescription: userText,
      period: period,
      nutriScore: quickAddMealState.nutriScore.value,
    );
    await addMeal(meal);
    computeDayAverages();
    quickAddMealState.userMealText.value = "";
    navigationService.closeBottomSheet();
  } catch (e) {
    print("ERROR TOTO");
    errorService.notifyError(e);
  } finally {
    quickAddMealState.isLoading.value = false;
  }
}
