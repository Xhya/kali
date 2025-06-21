import 'package:kalori/core/domains/ai.repository.dart';
import 'package:kalori/core/models/NutriScore.model.dart';

var aiService = AIService();

class AIService {
  final _aiRepository = AIRepository();

  Future<NutriScore> computeNutriScore(String userText) async {
    return await _aiRepository.computeNutriScore(userText);
  }
}
