import 'dart:convert';
import 'package:kali/core/domains/ai.repository.dart';
import 'package:kali/core/models/NutriScore.model.dart';
import 'package:kali/core/states/Ai.state.dart';
import 'package:uuid/uuid.dart';

var aiService = AIService();

class AIService {
  final _aiRepository = AIRepository();
  final _uuid = Uuid();


  Future<NutriScore> computeNutriScore(String userText) async {
    try {
      aiState.aiNotUnderstandError.value = false;
      final json = await _aiRepository.computeNutriScore(userText);
      final nutriScoreJson = jsonDecode(json);

      final nutriScore = NutriScore(
        id: _uuid.v6(),
        proteinAmount: nutriScoreJson["proteinAmount"],
        lipidAmount: nutriScoreJson["lipidAmount"],
        glucidAmount: nutriScoreJson["glucidAmount"],
        caloryAmount: nutriScoreJson["caloryAmount"],
      );

      if (nutriScore.isEmpty()) {
        aiState.aiNotUnderstandError.value = true;
        throw Exception("Empty nutri score");
      }
      
      return nutriScore;
    } catch (e) {
      aiState.aiNotUnderstandError.value = true;
      rethrow;
    }
  }

  Future<NutriScore> computePersonalNutriScore({
    required String height,
    required String age,
    required String weight,
  }) async {
    final json = await _aiRepository.computePersonalNutriScore(
      height: height,
      age: age,
      weight: weight,
    );
    final nutriScoreJson = jsonDecode(json);

    return NutriScore(
      id: _uuid.v6(),
      proteinAmount: nutriScoreJson["proteinAmount"],
      lipidAmount: nutriScoreJson["lipidAmount"],
      glucidAmount: nutriScoreJson["glucidAmount"],
      caloryAmount: nutriScoreJson["caloryAmount"],
    );
  }
}
