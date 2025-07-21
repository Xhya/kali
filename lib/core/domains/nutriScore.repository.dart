import 'package:kali/core/domains/nutriScore.data.dart';
import 'package:kali/core/models/NutriScore.model.dart';

class NutriScoreRepository {
  Future<NutriScore?> getPersonalNutriScore() async {
    return await nutriScoreData.getPersonalNutriScore();
  }

  Future<void> setPersonalNutriScore(NutriScore nutriScore) async {
    await nutriScoreData.setPersonalNutriScore(nutriScore);
  }
}
