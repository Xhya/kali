import 'package:kalori/core/domains/nutriScore.state.dart';
import 'package:kalori/core/services/AI.service.dart';

computeNutriScore(String userText) async {
  final nutriScore = await aiService.computeNutriScore(userText);
  nutriScoreState.setNutriScore(nutriScore);
}
