import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/core/models/MacroType.enum.dart';
import 'package:kali/core/models/MealPeriod.enum.dart';
import 'package:kali/core/models/meal.fixture.dart';
import 'package:kali/core/utils/getBars.utils.dart';
import 'package:kali/core/domains/meal.state.dart';

void main() {
  test('get bars 1', () async {
    mealState.currentMealPeriods.value = [];
    final bars = getBars(fixtureMeals, MacroTypeEnum.proteins);
    expect(bars, <Color, int>{style.period.allMealsColor.color!: 80});
    expect(bars.containsKey(style.period.breakfastColor.color!), false);
    expect(bars.containsKey(style.period.dinerColor.color!), false);
    expect(bars.containsKey(style.period.snackColor.color!), false);
    expect(bars.containsKey(style.period.lunchColor.color!), false);
  });

  test('get bars 2', () async {
    mealState.currentMealPeriods.value = [MealPeriodEnum.breakfast];
    final bars = getBars(fixtureMeals, MacroTypeEnum.proteins);
    expect(bars, <Color, int>{style.period.breakfastColor.color!: 30});
    expect(bars.containsKey(style.period.allMealsColor.color!), false);
    expect(bars.containsKey(style.period.dinerColor.color!), false);
    expect(bars.containsKey(style.period.snackColor.color!), false);
    expect(bars.containsKey(style.period.lunchColor.color!), false);
  });

  test('get bars 3', () async {
    mealState.currentMealPeriods.value = [MealPeriodEnum.lunch];
    final bars = getBars(fixtureMeals, MacroTypeEnum.proteins);
    expect(bars, <Color, int>{style.period.lunchColor.color!: 50});
    expect(bars.containsKey(style.period.allMealsColor.color!), false);
    expect(bars.containsKey(style.period.dinerColor.color!), false);
    expect(bars.containsKey(style.period.snackColor.color!), false);
    expect(bars.containsKey(style.period.breakfastColor.color!), false);
  });

  test('get bars 4', () async {
    mealState.currentMealPeriods.value = [MealPeriodEnum.dinner];
    final bars = getBars(fixtureMeals, MacroTypeEnum.proteins);
    expect(bars, <Color, int>{style.period.dinerColor.color!: 0});
    expect(bars.containsKey(style.period.allMealsColor.color!), false);
    expect(bars.containsKey(style.period.snackColor.color!), false);
    expect(bars.containsKey(style.period.breakfastColor.color!), false);
    expect(bars.containsKey(style.period.lunchColor.color!), false);
  });

  test('get bars 5', () async {
    mealState.currentMealPeriods.value = [
      MealPeriodEnum.breakfast,
      MealPeriodEnum.lunch,
    ];
    final bars = getBars(fixtureMeals, MacroTypeEnum.proteins);
    expect(bars, <Color, int>{
      style.period.breakfastColor.color!: 30,
      style.period.lunchColor.color!: 50,
    });
    expect(bars.containsKey(style.period.allMealsColor.color!), false);
    expect(bars.containsKey(style.period.snackColor.color!), false);
    expect(bars.containsKey(style.period.dinerColor.color!), false);
  });
}
