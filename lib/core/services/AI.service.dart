import 'dart:convert';
import 'package:kalori/core/domains/ai.repository.dart';
import 'package:kalori/core/models/NutriScore.model.dart';
import 'package:uuid/uuid.dart';

var aiService = AIService();

class AIService {
  final _aiRepository = AIRepository();
  final _uuid = Uuid();

  Future<NutriScore> computeNutriScore(String userText) async {
    final json = await _aiRepository.computeNutriScore(userText);
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
