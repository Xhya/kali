import 'package:kali/core/domains/nutriScore.repository.dart';
import 'package:kali/core/domains/nutriScore.state.dart';
import 'package:kali/core/models/NutriScore.model.dart';

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

Future<void> setPersonalNutriScore(NutriScore nutriScore) async {
  await NutriScoreRepository().setPersonalNutriScore(nutriScore);
}
