import 'package:flutter/material.dart';
import 'package:kali/client/widgets/CustomCard.widget.dart';
import 'package:kali/core/utils/computeRemainingCalories.utils.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/core/domains/nutriScore.state.dart';
import 'package:kali/core/models/NutriScore.model.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MainKaloriesCountWidget extends StatefulWidget {
  const MainKaloriesCountWidget({super.key});

  @override
  State<MainKaloriesCountWidget> createState() =>
      _MainKaloriesCountWidgetState();
}

class _MainKaloriesCountWidgetState extends State<MainKaloriesCountWidget> {
  @override
  Widget build(BuildContext context) {
    NutriScore? currentNutriScore =
        context.watch<NutriScoreState>().currentNutriScore.value;
    NutriScore? personalNutriScore =
        context.watch<NutriScoreState>().personalNutriScore.value;
    int? remainingCalories = context.select(
      (NutriScoreState v) => computeRemainingCalories(),
    );
    // NutriScoreByPeriod dateTotalNutriscoreByPeriod = getTotalNutriscoreByPeriod(
    //   widget.meals,
    // );

    return CustomCard(
      padding: EdgeInsets.all(16),
      child: Row(
        spacing: 12,
        children: [
          Text(
            "⚖️",
            textAlign: TextAlign.start,
            style: style.text.color1
                .merge(style.fontsize.md)
                .merge(style.fontweight.bold),
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (currentNutriScore?.caloryAmount != null &&
                    personalNutriScore?.caloryAmount != null)
                  Text(
                    "${currentNutriScore?.caloryAmount.toString()} / ${personalNutriScore?.caloryAmount.toString()}",
                    textAlign: TextAlign.start,
                    style: style.text.neutral
                        .merge(style.fontsize.md)
                        .merge(style.fontweight.bold),
                  ),
                if (currentNutriScore?.caloryAmount == null ||
                    personalNutriScore?.caloryAmount == null)
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
              if (remainingCalories != null)
                Text(
                  "$remainingCalories restantes 🔥",
                  textAlign: TextAlign.start,
                  style: style.text.neutralLight.merge(style.fontsize.sm),
                ),
              SizedBox(height: 4),
              SizedBox(
                width: 150,
                child: SfLinearGauge(
                  minimum: 0,
                  maximum: personalNutriScore?.caloryAmount.toDouble() ?? 0,
                  showLabels: false,
                  showTicks: false,
                  orientation: LinearGaugeOrientation.horizontal,
                  majorTickStyle: LinearTickStyle(length: 20),
                  axisTrackStyle: LinearAxisTrackStyle(
                    edgeStyle: LinearEdgeStyle.bothCurve,
                    color: style.background.greenDark.color,
                    thickness: 8,
                    borderColor: Colors.black,
                  ),
                  barPointers: [
                    LinearBarPointer(
                      value: currentNutriScore?.caloryAmount.toDouble() ?? 0,
                      color: style.gauge.main.color,
                      thickness: 8,
                      edgeStyle: LinearEdgeStyle.bothCurve,
                    ),
                  ],
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
