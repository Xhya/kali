import 'package:kali/core/domains/nutriScore.repository.dart';
import 'package:kali/core/services/User.service.dart';
import 'package:kali/core/states/nutriScore.state.dart';
import 'package:kali/core/models/NutriScore.model.dart';

class NutriScoreService {
  final NutriScoreRepository nutriScoreRepository = NutriScoreRepository();
}

Future<void> refreshPersonalNutriScore() async {
  final personalNutriScore = await userService.getPersonalNutriScore();

  if (personalNutriScore != null) {
    nutriScoreState.personalNutriScore.value = NutriScore(
      proteinAmount: personalNutriScore.proteinAmount,
      glucidAmount: personalNutriScore.glucidAmount,
      lipidAmount: personalNutriScore.lipidAmount,
      caloryAmount: personalNutriScore.caloryAmount,
    );
  }
}
