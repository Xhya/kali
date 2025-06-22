import 'package:kalori/core/services/AI.service.dart';
import 'package:kalori/client/states/quickAddMeal.state.dart';

computeNutriScore(String userText) async {
  quickAddMealState.isLoading.value = true;
  return await aiService.computeNutriScore(userText);
}
