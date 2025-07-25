import 'package:kali/core/domains/nutriScore.repository.dart';
import 'package:kali/core/states/nutriScore.state.dart';
import 'package:kali/core/models/NutriScore.model.dart';

class NutriScoreService {
  final NutriScoreRepository nutriScoreRepository = NutriScoreRepository();

  Future<NutriScore?> computePersonalNutriScore(
    PersonalNutriScoreFormData formData,
  ) async {
    return await nutriScoreRepository
        .computePersonalNutriScore(formData);
  }
}

Future<void> refreshPersonalNutriScore() async {
  final personalNutriScore =
      await NutriScoreRepository().getPersonalNutriScore();

  if (personalNutriScore != null) {
    nutriScoreState.personalNutriScore.value = NutriScore(
      proteinAmount: personalNutriScore.proteinAmount,
      glucidAmount: personalNutriScore.glucidAmount,
      lipidAmount: personalNutriScore.lipidAmount,
      caloryAmount: personalNutriScore.caloryAmount,
    );
  }
}
