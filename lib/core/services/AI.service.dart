import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:kali/core/domains/ai.repository.dart';
import 'package:kali/core/models/NutriScore.model.dart';
import 'package:uuid/uuid.dart';

var aiService = AIService();

class AIService {
  final _aiRepository = AIRepository();
  final _uuid = Uuid();

  final aiNotUnderstandError = ValueNotifier<bool>(false);

  Future<NutriScore> computeNutriScore(String userText) async {
    try {
      aiNotUnderstandError.value = false;
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
        aiNotUnderstandError.value = true;
        throw Exception("Empty nutri score");
      }
      
      return nutriScore;
    } catch (e) {
      aiNotUnderstandError.value = true;
      rethrow;
    }
  }

  Future<NutriScore> computePersonalNutriScore({
    required String size,
    required String age,
    required String weight,
  }) async {
    final json = await _aiRepository.computePersonalNutriScore(
      size: size,
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
