import 'package:kalori/core/domains/nutriScore.repository.dart';
import 'package:kalori/core/domains/nutriScore.state.dart';
import 'package:kalori/core/models/NutriScore.model.dart';

Future<void> refreshPersonalNutriScore() async {
  final personalNutriScore =
      await NutriScoreRepository().getPersonalNutriScore();

  if (personalNutriScore != null) {
    nutriScoreState.maximumNutriScore.value = NutriScore(
      proteinAmount: personalNutriScore.proteinAmount,
      glucidAmount: personalNutriScore.glucidAmount,
      lipidAmount: personalNutriScore.lipidAmount,
      caloryAmount: personalNutriScore.caloryAmount,
    );
  }
}

Future<void> setPersonalNutriScore(NutriScore nutriScore) async {
  
}
