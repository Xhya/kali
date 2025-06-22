import 'package:kalori/client/states/quickAddMeal.state.dart';
import 'package:kalori/core/domains/nutriScore.repository.dart';
import 'package:kalori/core/domains/nutriScore.state.dart';
import 'package:kalori/core/services/AI.service.dart';
import 'package:kalori/core/services/Error.service.dart';

initHomeScreen() async {
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
    nutriScoreState.currentNutriScore.value = nutriScore;
    quickAddMealState.isLoading.value = false;
    quickAddMealState.userMealText.value = "";
  } catch (e) {
    quickAddMealState.isLoading.value = false;
    errorService.notifyError(e);
  }
}
