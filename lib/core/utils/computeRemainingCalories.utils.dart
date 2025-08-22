import 'package:kali/core/models/NutriScore.model.dart';

int computeRemainingCalories(
  NutriScore nutriscore,
  NutriScore? personalNutriScore,
) {
  if (personalNutriScore == null) return 0;

  return (personalNutriScore.caloryAmount - nutriscore.caloryAmount).toInt();
}
