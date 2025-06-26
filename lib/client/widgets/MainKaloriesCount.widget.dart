import 'package:flutter/material.dart';
import 'package:kalori/core/utils/remaningCaloriesToSpend.utils.dart';
import 'package:provider/provider.dart';
import 'package:kalori/client/Style.service.dart';
import 'package:kalori/core/domains/nutriScore.state.dart';
import 'package:kalori/core/models/NutriScore.model.dart';
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: style.text.color1
                .merge(style.fontsize.xl)
                .merge(style.fontweight.bold),
            children: [
              TextSpan(text: 'Il te reste '),
              TextSpan(
                text: '${remaningCaloriesToSpend()} calories',
                style: style.text.reverse_neutral
                    .merge(style.fontsize.xl)
                    .merge(style.fontweight.bold),
              ),
              TextSpan(text: ' pour aujourd\'hui 🔥'),
            ],
          ),
        ),
        SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Consommées",
              textAlign: TextAlign.start,
              style: style.text.reverse_neutral
                  .merge(style.fontsize.xs)
                  .merge(style.fontweight.bold),
            ),
            Text(
              "${currentNutriScore?.caloryAmount.toString()} / ${personalNutriScore?.caloryAmount.toString()} kcal",
              textAlign: TextAlign.start,
              style: style.text.color1
                  .merge(style.fontsize.xs)
                  .merge(style.fontweight.bold),
            ),
          ],
        ),
        SizedBox(height: 4),
        SfLinearGauge(
          minimum: 0,
          maximum: personalNutriScore?.caloryAmount.toDouble() ?? 0,
          showLabels: false,
          showTicks: false,
          orientation: LinearGaugeOrientation.horizontal,
          majorTickStyle: LinearTickStyle(length: 20),
          axisLabelStyle: TextStyle(fontSize: 12.0, color: Colors.black),
          axisTrackStyle: LinearAxisTrackStyle(
            edgeStyle: LinearEdgeStyle.bothCurve,
            thickness: 15.0,
            borderColor: Colors.black,
          ),
          barPointers: [
            LinearBarPointer(
              value: currentNutriScore?.caloryAmount.toDouble() ?? 0,
              color: style.gauge.main.color,
              thickness: 15,
              edgeStyle: LinearEdgeStyle.bothCurve,
            ),
          ],
        ),
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
