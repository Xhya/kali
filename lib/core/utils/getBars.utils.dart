import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/NutriScoreByPeriod.type.dart';
import 'package:kali/core/states/meal.state.dart';
import 'package:kali/core/models/MacroType.enum.dart';
import 'package:kali/core/models/Meal.model.dart';
import 'package:kali/core/models/MealPeriod.enum.dart';
import 'package:kali/core/utils/getTotalNutriscoreByPeriod.utils.dart';

Map<Color, int> getBars(
  List<MealModel> mealsByPeriods,
  MacroTypeEnum macroType,
) {
  NutriScoreByPeriod dateTotalNutriscoreByPeriod = getTotalNutriscoreByPeriod(
    mealsByPeriods,
  );

  final selectedPeriods = mealState.currentMealPeriods.value;

  if (selectedPeriods.isEmpty) {
    if (macroType == MacroTypeEnum.proteins) {
      return <Color, int>{
        style.period.allMealsColor.color!:
            dateTotalNutriscoreByPeriod[MealPeriodEnum.breakfast]!
                .proteinAmount +
            dateTotalNutriscoreByPeriod[MealPeriodEnum.lunch]!.proteinAmount +
            dateTotalNutriscoreByPeriod[MealPeriodEnum.snack]!.proteinAmount +
            dateTotalNutriscoreByPeriod[MealPeriodEnum.dinner]!.proteinAmount,
      };
    }

    if (macroType == MacroTypeEnum.glucids) {
      return <Color, int>{
        style.period.allMealsColor.color!:
            dateTotalNutriscoreByPeriod[MealPeriodEnum.breakfast]!
                .glucidAmount +
            dateTotalNutriscoreByPeriod[MealPeriodEnum.lunch]!.glucidAmount +
            dateTotalNutriscoreByPeriod[MealPeriodEnum.snack]!.glucidAmount +
            dateTotalNutriscoreByPeriod[MealPeriodEnum.dinner]!.glucidAmount,
      };
    }

    if (macroType == MacroTypeEnum.lipids) {
      return <Color, int>{
        style.period.allMealsColor.color!:
            dateTotalNutriscoreByPeriod[MealPeriodEnum.breakfast]!.lipidAmount +
            dateTotalNutriscoreByPeriod[MealPeriodEnum.lunch]!.lipidAmount +
            dateTotalNutriscoreByPeriod[MealPeriodEnum.snack]!.lipidAmount +
            dateTotalNutriscoreByPeriod[MealPeriodEnum.dinner]!.lipidAmount,
      };
    }

    if (macroType == MacroTypeEnum.calories) {
      return <Color, int>{
        style.period.allMealsColor.color!:
            dateTotalNutriscoreByPeriod[MealPeriodEnum.breakfast]!
                .caloryAmount +
            dateTotalNutriscoreByPeriod[MealPeriodEnum.lunch]!.caloryAmount +
            dateTotalNutriscoreByPeriod[MealPeriodEnum.snack]!.caloryAmount +
            dateTotalNutriscoreByPeriod[MealPeriodEnum.dinner]!.caloryAmount,
      };
    }
  }

  if (macroType == MacroTypeEnum.proteins) {
    final proteinsBreakfast =
        dateTotalNutriscoreByPeriod[MealPeriodEnum.breakfast]!.proteinAmount;
    final proteinsLunch =
        dateTotalNutriscoreByPeriod[MealPeriodEnum.lunch]!.proteinAmount;
    final proteinsSnack =
        dateTotalNutriscoreByPeriod[MealPeriodEnum.snack]!.proteinAmount;
    final proteinsDinner =
        dateTotalNutriscoreByPeriod[MealPeriodEnum.dinner]!.proteinAmount;

    return <Color, int>{
      if (selectedPeriods.contains(MealPeriodEnum.breakfast) &&
          proteinsBreakfast > 0)
        style.period.breakfastColor.color!: proteinsBreakfast,
      if (selectedPeriods.contains(MealPeriodEnum.lunch) && proteinsLunch > 0)
        style.period.lunchColor.color!: proteinsLunch,
      if (selectedPeriods.contains(MealPeriodEnum.snack) && proteinsSnack > 0)
        style.period.snackColor.color!: proteinsSnack,
      if (selectedPeriods.contains(MealPeriodEnum.dinner) && proteinsDinner > 0)
        style.period.dinerColor.color!: proteinsDinner,
    };
  }

  if (macroType == MacroTypeEnum.glucids) {
    final glucidsBreakfast =
        dateTotalNutriscoreByPeriod[MealPeriodEnum.breakfast]!.glucidAmount;
    final glucidsLunch =
        dateTotalNutriscoreByPeriod[MealPeriodEnum.lunch]!.glucidAmount;
    final glucidsSnack =
        dateTotalNutriscoreByPeriod[MealPeriodEnum.snack]!.glucidAmount;
    final glucidsDinner =
        dateTotalNutriscoreByPeriod[MealPeriodEnum.dinner]!.glucidAmount;

    return <Color, int>{
      if (selectedPeriods.contains(MealPeriodEnum.breakfast) &&
          glucidsBreakfast > 0)
        style.period.breakfastColor.color!: glucidsBreakfast,
      if (selectedPeriods.contains(MealPeriodEnum.lunch) && glucidsLunch > 0)
        style.period.lunchColor.color!: glucidsLunch,
      if (selectedPeriods.contains(MealPeriodEnum.snack) && glucidsSnack > 0)
        style.period.snackColor.color!: glucidsSnack,
      if (selectedPeriods.contains(MealPeriodEnum.dinner) && glucidsDinner > 0)
        style.period.dinerColor.color!: glucidsDinner,
    };
  }

  if (macroType == MacroTypeEnum.lipids) {
    final lipidsBreakfast =
        dateTotalNutriscoreByPeriod[MealPeriodEnum.breakfast]!.lipidAmount;
    final lipidsLunch =
        dateTotalNutriscoreByPeriod[MealPeriodEnum.lunch]!.lipidAmount;
    final lipidsSnack =
        dateTotalNutriscoreByPeriod[MealPeriodEnum.snack]!.lipidAmount;
    final lipidsDinner =
        dateTotalNutriscoreByPeriod[MealPeriodEnum.dinner]!.lipidAmount;

    return <Color, int>{
      if (selectedPeriods.contains(MealPeriodEnum.breakfast) &&
          lipidsBreakfast > 0)
        style.period.breakfastColor.color!: lipidsBreakfast,
      if (selectedPeriods.contains(MealPeriodEnum.lunch) && lipidsLunch > 0)
        style.period.lunchColor.color!: lipidsLunch,
      if (selectedPeriods.contains(MealPeriodEnum.snack) && lipidsSnack > 0)
        style.period.snackColor.color!: lipidsSnack,
      if (selectedPeriods.contains(MealPeriodEnum.dinner) && lipidsDinner > 0)
        style.period.dinerColor.color!: lipidsDinner,
    };
  }

  if (macroType == MacroTypeEnum.calories) {
    final caloryBreakfast =
        dateTotalNutriscoreByPeriod[MealPeriodEnum.breakfast]!.caloryAmount;
    final caloryLunch =
        dateTotalNutriscoreByPeriod[MealPeriodEnum.lunch]!.caloryAmount;
    final calorySnack =
        dateTotalNutriscoreByPeriod[MealPeriodEnum.snack]!.caloryAmount;
    final caloryDinner =
        dateTotalNutriscoreByPeriod[MealPeriodEnum.dinner]!.caloryAmount;

    return <Color, int>{
      if (selectedPeriods.contains(MealPeriodEnum.breakfast) &&
          caloryBreakfast > 0)
        style.period.breakfastColor.color!: caloryBreakfast,
      if (selectedPeriods.contains(MealPeriodEnum.lunch) && caloryLunch > 0)
        style.period.lunchColor.color!: caloryLunch,
      if (selectedPeriods.contains(MealPeriodEnum.snack) && calorySnack > 0)
        style.period.snackColor.color!: calorySnack,
      if (selectedPeriods.contains(MealPeriodEnum.dinner) && caloryDinner > 0)
        style.period.dinerColor.color!: caloryDinner,
    };
  }

  return {};
}
