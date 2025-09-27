import 'package:flutter/material.dart';
import 'package:kali/client/widgets/BarGauge.widget.dart';
import 'package:kali/client/widgets/CustomCard.widget.dart';
import 'package:kali/core/models/MacroType.enum.dart';
import 'package:kali/core/models/MealPeriod.enum.dart';
import 'package:kali/core/states/meal.state.dart';
import 'package:kali/core/states/user.state.dart';
import 'package:kali/core/utils/getBars.utils.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/core/models/NutriScore.model.dart';

class MainKaloriesCountWidget extends StatefulWidget {
  const MainKaloriesCountWidget({super.key});

  @override
  State<MainKaloriesCountWidget> createState() =>
      _MainKaloriesCountWidgetState();
}

class _MainKaloriesCountWidgetState extends State<MainKaloriesCountWidget> {
  @override
  Widget build(BuildContext context) {
    final currentMealsByPeriods =
        context.watch<MealState>().currentMealsByPeriods;
    NutriScore mealsNutriScore = context.watch<MealState>().mealsNutriScore;
    NutriScore? personalNutriScore =
        context.watch<UserState>().user.value?.nutriscore;
    int remainingCalories = context.watch<MealState>().remainingCalories;

    final bars = getBars(currentMealsByPeriods, MacroTypeEnum.calories);

    List<MealPeriodEnum> currentMealPeriods =
        context.watch<MealState>().currentMealPeriods.value;

    var textColor = style.text.neutral;
    if (currentMealPeriods.isEmpty && personalNutriScore != null) {
      if (bars.entries.elementAt(0).value >
          personalNutriScore.caloryAmount.toInt() * 1.1) {
        textColor = style.statuses.notGood;
      }
      if (bars.entries.elementAt(0).value <
              personalNutriScore.caloryAmount.toInt() * 1.1 &&
          bars.entries.elementAt(0).value >
              personalNutriScore.caloryAmount.toInt() * 0.9) {
        textColor = style.statuses.average;
      }
    }

    return CustomCard(
      padding: EdgeInsets.all(16),
      child: Row(
        spacing: 12,
        children: [
          Text(
            "⚖️",
            textAlign: TextAlign.start,
            style: style.text.green
                .merge(style.fontsize.md)
                .merge(style.fontweight.bold),
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (personalNutriScore?.caloryAmount != null)
                  Text(
                    "${mealsNutriScore.caloryAmount.toString()} / ${personalNutriScore?.caloryAmount.toString()}",
                    textAlign: TextAlign.start,
                    style: style.text.neutral
                        .merge(style.fontsize.sm)
                        .merge(style.fontweight.bold),
                  ),
                if (personalNutriScore?.caloryAmount == null)
                  Text(
                    "...",
                    textAlign: TextAlign.start,
                    style: style.text.neutral
                        .merge(style.fontsize.sm)
                        .merge(style.fontweight.bold),
                  ),
                Text(
                  "calories",
                  textAlign: TextAlign.start,
                  style: style.text.neutral.merge(style.fontsize.sm),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (currentMealPeriods.isEmpty)
                Text(
                  "$remainingCalories restantes 🔥",
                  textAlign: TextAlign.start,
                  style: style.text.neutralLight
                      .merge(style.fontsize.sm)
                      .merge(textColor),
                ),
              SizedBox(height: 4),
              if (personalNutriScore?.caloryAmount != null)
                SizedBox(
                  width: 150,
                  child: BarGaugeWidget(
                    maxAmount: personalNutriScore?.caloryAmount ?? 0,
                    bars: bars,
                  ),
                ),
            ],
          ),
        ],
      ),
    );

    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [

          ],
        ),
        SizedBox(height: 4),

        SizedBox(height: 4),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(
        //       "Brûlées",
        //       textAlign: TextAlign.start,
        //       style: style.text.reverse_neutral
        //           .merge(style.fontsize.xs)
        //           .merge(style.fontweight.bold),
        //     ),
        //     Text(
        //       "1250 / 1700",
        //       textAlign: TextAlign.start,
        //       style: style.text.color1
        //           .merge(style.fontsize.xs)
        //           .merge(style.fontweight.bold),
        //     ),
        // ],
        // ),
      ],
    );
  }
}
