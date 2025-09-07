import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/CircleGauge.widget.dart';
import 'package:kali/client/widgets/CustomCard.widget.dart';
import 'package:kali/core/states/editMeal.state.dart';
import 'package:kali/core/states/meal.state.dart';
import 'package:kali/core/models/MacroType.enum.dart';
import 'package:kali/core/models/Meal.model.dart';
import 'package:kali/core/models/NutriScore.model.dart';
import 'package:kali/core/states/user.state.dart';
import 'package:kali/core/utils/computeDayAverages.utils.dart';
import 'package:kali/core/utils/getBars.utils.dart';
import 'package:kali/core/utils/macroIcon.utils.dart';
import 'package:provider/provider.dart';
import 'package:kali/core/services/Translation.service.dart';

class NutriScoreGaugesWidget extends StatefulWidget {
  const NutriScoreGaugesWidget({
    super.key,
    required this.mealsByPeriods,
    this.withTotal = true,
  });

  final List<MealModel> mealsByPeriods;
  final bool withTotal;

  @override
  State<NutriScoreGaugesWidget> createState() => _NutriScoreGaugesWidgetState();
}

class _NutriScoreGaugesWidgetState extends State<NutriScoreGaugesWidget> {
  final double gaugeHeight = 80;
  final double gaugeWidth = 80;

  @override
  Widget build(BuildContext context) {
    NutriScore mealsNutriScore = computeDayAverages(widget.mealsByPeriods);
    NutriScore? personalNutriScore =
        context.watch<UserState>().personalNutriscore;
    NutriScore? editingNutriScore =
        context.watch<EditMealState>().editingNutriScore.value;

    final proteinBars = getBars(widget.mealsByPeriods, MacroTypeEnum.proteins);

    final lipidBars = getBars(widget.mealsByPeriods, MacroTypeEnum.lipids);

    final glucidBars = getBars(widget.mealsByPeriods, MacroTypeEnum.glucids);

    if (personalNutriScore != null) {
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
                      SizedBox(height: 16),
                      SizedBox(
                        height: gaugeHeight,
                        width: gaugeWidth,
                        child: CircleGaugeWidget(
                          maxAmount: personalNutriScore.proteinAmount.toInt(),
                          editingAmount:
                              editingNutriScore?.proteinAmount.toInt(),
                          bars: proteinBars,
                          textCenter: proteinIcon,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        widget.withTotal
                            ? "${mealsNutriScore.proteinAmount}/${personalNutriScore.proteinAmount}g"
                            : "${mealsNutriScore.proteinAmount}g",
                        style: style.fontsize.sm
                            .merge(style.text.neutral)
                            .merge(style.fontweight.bold),
                      ),
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
                      SizedBox(
                        height: gaugeHeight,
                        width: gaugeWidth,
                        child: CircleGaugeWidget(
                          maxAmount: personalNutriScore.glucidAmount.toInt(),
                          editingAmount:
                              editingNutriScore?.glucidAmount.toInt(),
                          bars: glucidBars,
                          textCenter: lipidIcon,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        widget.withTotal
                            ? "${mealsNutriScore.glucidAmount}/${personalNutriScore.glucidAmount}g"
                            : "${mealsNutriScore.glucidAmount}g",
                        style: style.fontsize.sm
                            .merge(style.text.neutral)
                            .merge(style.fontweight.bold),
                      ),
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
                      SizedBox(
                        height: gaugeHeight,
                        width: gaugeWidth,
                        child: CircleGaugeWidget(
                          maxAmount: personalNutriScore.lipidAmount.toInt(),
                          editingAmount: editingNutriScore?.lipidAmount.toInt(),
                          bars: lipidBars,
                          textCenter: glucidIcon,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        widget.withTotal
                            ? "${mealsNutriScore.lipidAmount}/${personalNutriScore.lipidAmount}g"
                            : "${mealsNutriScore.lipidAmount}g",
                        style: style.fontsize.sm
                            .merge(style.text.neutral)
                            .merge(style.fontweight.bold),
                      ),
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
