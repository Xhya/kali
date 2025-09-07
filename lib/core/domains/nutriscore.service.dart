import 'package:kali/core/domains/nutriScore.repository.dart';
import 'package:kali/core/models/NutriScore.model.dart';

final nutriscoreService = NutriscoreService();

class NutriscoreService {
  final NutriScoreRepository _nutriScoreRepository = NutriScoreRepository();

  Future<NutriScore?> computeNutriScore({required String userText}) async {
    return await _nutriScoreRepository.computeNutriScore(userText: userText);
  }
}
