import 'package:kali/core/domains/nutriScore.repository.dart';
import 'package:kali/core/models/NutriScore.model.dart';
import 'package:kali/core/states/nutriScore.state.dart';

final nutriscoreService = NutriscoreService();

class NutriscoreService {
  final NutriScoreRepository _nutriScoreRepository = NutriScoreRepository();

  Future<NutriScore?> computeNutriScore({required String userText}) async {
    return await _nutriScoreRepository.computeNutriScore(userText: userText);
  }

  Future<NutriScore?> getNutriscore({required String nutriscoreId}) async {
    return await _nutriScoreRepository.getNutriscore(
      nutriscoreId: nutriscoreId,
    );
  }

  Future<void> searchNutriscore({required String text}) async {
    if (text.length < 10) {
      nutriScoreState.searchNutriscores.value = await _nutriScoreRepository
          .searchNutriscore(text: text);
    } else {
      nutriScoreState.searchNutriscores.value = [];
    }
  }
}
