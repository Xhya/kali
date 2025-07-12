import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/CustomCard.widget.dart';
import 'package:kali/client/states/editMeal.state.dart';
import 'package:kali/client/widgets/NutriScoreByPeriod.type.dart';
import 'package:kali/core/domains/nutriScore.state.dart';
import 'package:kali/core/models/Meal.model.dart';
import 'package:kali/core/models/MealPeriod.enum.dart';
import 'package:kali/core/models/NutriScore.model.dart';
import 'package:kali/core/utils/getTotalNutriscoreByPeriod.utils.dart';
import 'package:kali/core/utils/macroIcon.utils.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/widgets/Gauge.widget.dart';
import 'package:kali/core/services/Translation.service.dart';

class NutriScoreGaugesWidget extends StatefulWidget {
  const NutriScoreGaugesWidget({super.key, required this.meals});

  final List<MealModel> meals;

  @override
  State<NutriScoreGaugesWidget> createState() => _NutriScoreGaugesWidgetState();
}

class _NutriScoreGaugesWidgetState extends State<NutriScoreGaugesWidget> {
  final double gaugeHeight = 150;

  @override
  Widget build(BuildContext context) {
    NutriScore? currentNutriScore =
        context.watch<NutriScoreState>().currentNutriScore.value;
    NutriScoreByPeriod dateTotalNutriscoreByPeriod =
        getTotalNutriscoreByPeriod(widget.meals);
    NutriScore? personalNutriScore =
        context.watch<NutriScoreState>().personalNutriScore.value;
    NutriScore? editingNutriScore =
        context.watch<EditMealState>().editingNutriScore.value;

    if (currentNutriScore != null && personalNutriScore != null) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            spacing: 8,
            children: [
              Expanded(
                child: CustomCard(
                  child: Column(
                    children: [
                      SizedBox(height: 12),
                      Text(
                        proteinIcon,
                        style: style.fontsize.xl.merge(style.text.neutral),
                      ),
                      Text(
                        t('proteins').toLowerCase(),
                        style: style.fontsize.sm.merge(
                          style.text.reverse_neutral,
                        ),
                      ),
                      SizedBox(height: 12),
                      SizedBox(
                        height: gaugeHeight,
                        child: GaugeWidget(
                          currentAmount:
                              currentNutriScore.proteinAmount.toInt(),
                          maxAmount: personalNutriScore.proteinAmount.toInt(),
                          editingAmount:
                              editingNutriScore?.proteinAmount.toInt(),
                          bars: {
                            style.period.dinerColor.color!:
                                dateTotalNutriscoreByPeriod[MealPeriodEnum
                                        .dinner]!
                                    .proteinAmount,
                            style.period.snackColor.color!:
                                dateTotalNutriscoreByPeriod[MealPeriodEnum
                                        .snack]!
                                    .proteinAmount,
                            style.period.lunchColor.color!:
                                dateTotalNutriscoreByPeriod[MealPeriodEnum
                                        .lunch]!
                                    .proteinAmount,
                            style.period.breakfastColor.color!:
                                dateTotalNutriscoreByPeriod[MealPeriodEnum
                                        .breakfast]!
                                    .proteinAmount,
                          },
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        "${currentNutriScore.proteinAmount} / ${personalNutriScore.proteinAmount}g",
                        style: style.fontsize.sm.merge(
                          style.text.reverse_neutral,
                        ),
                      ),
                      SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: CustomCard(
                  child: Column(
                    children: [
                      SizedBox(height: 12),
                      Text(
                        glucidIcon,
                        style: style.fontsize.xl.merge(style.text.neutral),
                      ),
                      Text(
                        t('lipids').toLowerCase(),
                        style: style.fontsize.sm.merge(
                          style.text.reverse_neutral,
                        ),
                      ),
                      SizedBox(height: 12),
                      SizedBox(
                        height: gaugeHeight,
                        child: GaugeWidget(
                          currentAmount: currentNutriScore.lipidAmount.toInt(),
                          maxAmount: personalNutriScore.lipidAmount.toInt(),
                          editingAmount: editingNutriScore?.lipidAmount.toInt(),
                          bars: {
                            style.period.dinerColor.color!:
                                dateTotalNutriscoreByPeriod[MealPeriodEnum
                                        .dinner]!
                                    .lipidAmount,
                            style.period.snackColor.color!:
                                dateTotalNutriscoreByPeriod[MealPeriodEnum
                                        .snack]!
                                    .lipidAmount,
                            style.period.lunchColor.color!:
                                dateTotalNutriscoreByPeriod[MealPeriodEnum
                                        .lunch]!
                                    .lipidAmount,
                            style.period.breakfastColor.color!:
                                dateTotalNutriscoreByPeriod[MealPeriodEnum
                                        .breakfast]!
                                    .lipidAmount,
                          },
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        "${currentNutriScore.lipidAmount} / ${personalNutriScore.lipidAmount}g",
                        style: style.fontsize.sm.merge(
                          style.text.reverse_neutral,
                        ),
                      ),
                      SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: CustomCard(
                  child: Column(
                    children: [
                      SizedBox(height: 12),
                      Text(
                        lipidIcon,
                        style: style.fontsize.xl.merge(style.text.neutral),
                      ),
                      Text(
                        t('glucids').toLowerCase(),
                        style: style.fontsize.sm.merge(
                          style.text.reverse_neutral,
                        ),
                      ),
                      SizedBox(height: 12),
                      SizedBox(
                        height: gaugeHeight,
                        child: GaugeWidget(
                          currentAmount: currentNutriScore.glucidAmount.toInt(),
                          maxAmount: personalNutriScore.glucidAmount.toInt(),
                          editingAmount:
                              editingNutriScore?.glucidAmount.toInt(),
                          bars: {
                            style.period.dinerColor.color!:
                                dateTotalNutriscoreByPeriod[MealPeriodEnum
                                        .dinner]!
                                    .glucidAmount,
                            style.period.snackColor.color!:
                                dateTotalNutriscoreByPeriod[MealPeriodEnum
                                        .snack]!
                                    .glucidAmount,
                            style.period.lunchColor.color!:
                                dateTotalNutriscoreByPeriod[MealPeriodEnum
                                        .lunch]!
                                    .glucidAmount,
                            style.period.breakfastColor.color!:
                                dateTotalNutriscoreByPeriod[MealPeriodEnum
                                        .breakfast]!
                                    .glucidAmount,
                          },
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        "${currentNutriScore.glucidAmount} / ${personalNutriScore.glucidAmount}g",
                        style: style.fontsize.sm.merge(
                          style.text.reverse_neutral,
                        ),
                      ),
                      SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
