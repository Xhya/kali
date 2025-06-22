import 'package:kalori/core/domains/nutriScore.data.dart';
import 'package:kalori/core/models/NutriScore.model.dart';

class NutriScoreRepository {
  Future<List<NutriScore>> getNutriScores() async {
    return await nutriScoreData.getNutriScores();
  }
}
