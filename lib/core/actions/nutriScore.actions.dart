import 'package:kalori/client/states/quickAddMeal.state.dart';
import 'package:kalori/core/domains/nutriScore.repository.dart';
import 'package:kalori/core/domains/nutriScore.state.dart';
import 'package:kalori/core/services/AI.service.dart';

initHomeScreen() async {
  final list = await NutriScoreRepository().getNutriScores();
  nutriScoreState.userNutriScores.value = List.from(list);
}

computeNutriScore(String userText) async {
  quickAddMealState.isLoading.value = true;
  final nutriScore = await aiService.computeNutriScore(userText);
  nutriScoreState.currentNutriScore.value = nutriScore;
  quickAddMealState.isLoading.value = false;
  quickAddMealState.userMealText.value = "";
}
