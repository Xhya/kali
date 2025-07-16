import 'package:kali/core/models/NutriScore.model.dart';

final emptyNutriScore = NutriScore(
  id: "1",
  proteinAmount: 0,
  lipidAmount: 0,
  glucidAmount: 0,
  caloryAmount: 0,
);

final fixtureNutriScore1 = NutriScore(
  id: "0",
  proteinAmount: 30,
  lipidAmount: 20,
  glucidAmount: 50,
  caloryAmount: 122,
);

final fixtureNutriScore2 = NutriScore(
  id: "1",
  proteinAmount: 50,
  lipidAmount: 40,
  glucidAmount: 100,
  caloryAmount: 544,
);
