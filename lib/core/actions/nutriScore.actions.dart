import 'package:kalori/client/states/quickAddMeal.state.dart';
import 'package:kalori/core/domains/nutriScore.repository.dart';
import 'package:kalori/core/domains/nutriScore.state.dart';
import 'package:kalori/core/models/NutriScore.model.dart';
import 'package:kalori/core/services/AI.service.dart';
import 'package:kalori/core/services/Error.service.dart';

initHomeScreen() async {
  try {
    await _refreshNutriScores();
  } catch (e) {
    errorService.notifyError(e);
  }
}

_refreshNutriScores() async {
  try {
    final list = await NutriScoreRepository().getNutriScores();
    nutriScoreState.userNutriScores.value = List.from(list);
  } catch (e) {
    errorService.notifyError(e);
  }
}

computeNutriScore(String userText) async {
  try {
    quickAddMealState.isLoading.value = true;
    final nutriScore = await aiService.computeNutriScore(userText);
    await _addNutriScore(nutriScore);
    // nutriScoreState.currentNutriScore.value = nutriScore;
    quickAddMealState.isLoading.value = false;
    quickAddMealState.userMealText.value = "";
    quickAddMealState.isInAddingMode.value = false;
  } catch (e) {
    quickAddMealState.isLoading.value = false;
    errorService.notifyError(e);
  }
}

_addNutriScore(NutriScore nutriScore) async {
  try {
    await NutriScoreRepository().addNutriScore(nutriScore);
    await _refreshNutriScores();
  } catch (e) {
    errorService.notifyError(e);
  }
}
