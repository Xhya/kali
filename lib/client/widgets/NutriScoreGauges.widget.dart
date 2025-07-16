import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/CircleGauge.widget.dart';
import 'package:kali/client/widgets/CustomCard.widget.dart';
import 'package:kali/client/states/editMeal.state.dart';
import 'package:kali/core/domains/nutriScore.state.dart';
import 'package:kali/core/models/MacroType.enum.dart';
import 'package:kali/core/models/Meal.model.dart';
import 'package:kali/core/models/NutriScore.model.dart';
import 'package:kali/core/utils/getBars.utils.dart';
import 'package:kali/core/utils/macroIcon.utils.dart';
import 'package:provider/provider.dart';
import 'package:kali/core/services/Translation.service.dart';

class NutriScoreGaugesWidget extends StatefulWidget {
  const NutriScoreGaugesWidget({super.key, required this.meals});

  final List<MealModel> meals;

  @override
  State<NutriScoreGaugesWidget> createState() => _NutriScoreGaugesWidgetState();
}

class _NutriScoreGaugesWidgetState extends State<NutriScoreGaugesWidget> {
  final double gaugeHeight = 80;
  final double gaugeWidth = 80;

  @override
  Widget build(BuildContext context) {
    NutriScore? currentNutriScore =
        context.watch<NutriScoreState>().currentNutriScore.value;
    NutriScore? personalNutriScore =
        context.watch<NutriScoreState>().personalNutriScore.value;
    NutriScore? editingNutriScore =
        context.watch<EditMealState>().editingNutriScore.value;

    final proteinBars = getBars(widget.meals, MacroTypeEnum.proteins);

    final lipidBars = getBars(widget.meals, MacroTypeEnum.lipids);

    final glucidBars = getBars(widget.meals, MacroTypeEnum.glucids);

    if (currentNutriScore != null && personalNutriScore != null) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            spacing: 4,
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
                        "${currentNutriScore.proteinAmount} / ${personalNutriScore.proteinAmount}g",
                        style: style.fontsize.sm
                            .merge(style.text.neutral)
                            .merge(style.fontweight.bold),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        height: gaugeHeight,
                        width: gaugeWidth,
                        child: CircleGaugeWidget(
                          maxAmount: personalNutriScore.proteinAmount.toInt(),
                          editingAmount:
                              editingNutriScore?.proteinAmount.toInt(),
                          bars: proteinBars,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        t('proteins').toLowerCase(),
                        style: style.fontsize.sm.merge(style.text.neutral),
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
                        "${currentNutriScore.glucidAmount} / ${personalNutriScore.glucidAmount}g",
                        style: style.fontsize.sm
                            .merge(style.text.neutral)
                            .merge(style.fontweight.bold),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        height: gaugeHeight,
                        width: gaugeWidth,
                        child: CircleGaugeWidget(
                          maxAmount: personalNutriScore.glucidAmount.toInt(),
                          editingAmount:
                              editingNutriScore?.glucidAmount.toInt(),
                          bars: glucidBars,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        t('glucids').toLowerCase(),
                        style: style.fontsize.sm.merge(style.text.neutral),
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
                        "${currentNutriScore.lipidAmount} / ${personalNutriScore.lipidAmount}g",
                        style: style.fontsize.sm
                            .merge(style.text.neutral)
                            .merge(style.fontweight.bold),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        height: gaugeHeight,
                        width: gaugeWidth,
                        child: CircleGaugeWidget(
                          maxAmount: personalNutriScore.lipidAmount.toInt(),
                          editingAmount: editingNutriScore?.lipidAmount.toInt(),
                          bars: lipidBars,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        t('lipids').toLowerCase(),
                        style: style.fontsize.sm.merge(style.text.neutral),
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
