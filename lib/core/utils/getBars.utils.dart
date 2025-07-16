import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/NutriScoreByPeriod.type.dart';
import 'package:kali/core/domains/meal.state.dart';
import 'package:kali/core/models/MacroType.enum.dart';
import 'package:kali/core/models/Meal.model.dart';
import 'package:kali/core/models/MealPeriod.enum.dart';
import 'package:kali/core/utils/getTotalNutriscoreByPeriod.utils.dart';

Map<Color, int> getBars(List<MealModel> meals, MacroTypeEnum macroType) {
  NutriScoreByPeriod dateTotalNutriscoreByPeriod = getTotalNutriscoreByPeriod(
    meals,
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
    return <Color, int>{
      if (selectedPeriods.contains(MealPeriodEnum.breakfast))
        style.period.breakfastColor.color!:
            dateTotalNutriscoreByPeriod[MealPeriodEnum.breakfast]!
                .proteinAmount,
      if (selectedPeriods.contains(MealPeriodEnum.lunch))
        style.period.lunchColor.color!:
            dateTotalNutriscoreByPeriod[MealPeriodEnum.lunch]!.proteinAmount,
      if (selectedPeriods.contains(MealPeriodEnum.snack))
        style.period.snackColor.color!:
            dateTotalNutriscoreByPeriod[MealPeriodEnum.snack]!.proteinAmount,
      if (selectedPeriods.contains(MealPeriodEnum.dinner))
        style.period.dinerColor.color!:
            dateTotalNutriscoreByPeriod[MealPeriodEnum.dinner]!.proteinAmount,
    };
  }

  if (macroType == MacroTypeEnum.glucids) {
    return <Color, int>{
      if (selectedPeriods.contains(MealPeriodEnum.breakfast))
        style.period.breakfastColor.color!:
            dateTotalNutriscoreByPeriod[MealPeriodEnum.breakfast]!.glucidAmount,
      if (selectedPeriods.contains(MealPeriodEnum.lunch))
        style.period.lunchColor.color!:
            dateTotalNutriscoreByPeriod[MealPeriodEnum.lunch]!.glucidAmount,
      if (selectedPeriods.contains(MealPeriodEnum.snack))
        style.period.snackColor.color!:
            dateTotalNutriscoreByPeriod[MealPeriodEnum.snack]!.glucidAmount,
      if (selectedPeriods.contains(MealPeriodEnum.dinner))
        style.period.dinerColor.color!:
            dateTotalNutriscoreByPeriod[MealPeriodEnum.dinner]!.glucidAmount,
    };
  }

  if (macroType == MacroTypeEnum.lipids) {
    return <Color, int>{
      if (selectedPeriods.contains(MealPeriodEnum.breakfast))
        style.period.breakfastColor.color!:
            dateTotalNutriscoreByPeriod[MealPeriodEnum.breakfast]!.lipidAmount,
      if (selectedPeriods.contains(MealPeriodEnum.lunch))
        style.period.lunchColor.color!:
            dateTotalNutriscoreByPeriod[MealPeriodEnum.lunch]!.lipidAmount,
      if (selectedPeriods.contains(MealPeriodEnum.snack))
        style.period.snackColor.color!:
            dateTotalNutriscoreByPeriod[MealPeriodEnum.snack]!.lipidAmount,
      if (selectedPeriods.contains(MealPeriodEnum.dinner))
        style.period.dinerColor.color!:
            dateTotalNutriscoreByPeriod[MealPeriodEnum.dinner]!.lipidAmount,
    };
  }

  if (macroType == MacroTypeEnum.calories) {
    return <Color, int>{
      if (selectedPeriods.contains(MealPeriodEnum.breakfast))
        style.period.breakfastColor.color!:
            dateTotalNutriscoreByPeriod[MealPeriodEnum.breakfast]!.caloryAmount,
      if (selectedPeriods.contains(MealPeriodEnum.lunch))
        style.period.lunchColor.color!:
            dateTotalNutriscoreByPeriod[MealPeriodEnum.lunch]!.caloryAmount,
      if (selectedPeriods.contains(MealPeriodEnum.snack))
        style.period.snackColor.color!:
            dateTotalNutriscoreByPeriod[MealPeriodEnum.snack]!.caloryAmount,
      if (selectedPeriods.contains(MealPeriodEnum.dinner))
        style.period.dinerColor.color!:
            dateTotalNutriscoreByPeriod[MealPeriodEnum.dinner]!.caloryAmount,
    };
  }

  return {};
}
