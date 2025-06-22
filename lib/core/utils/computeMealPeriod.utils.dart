import 'package:kalori/core/models/MealPeriod.enum.dart';

MealPeriodEnum computeMealPeriod(DateTime time) {
  return time.hour < 11
      ? MealPeriodEnum.breakfast
      : time.hour < 15
      ? MealPeriodEnum.lunch
      : time.hour < 18
      ? MealPeriodEnum.snack
      : MealPeriodEnum.dinner;
}
