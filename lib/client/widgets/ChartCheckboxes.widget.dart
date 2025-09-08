import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/core/states/chart.state.dart';
import 'package:provider/provider.dart';

class ChartCheckboxesWidget extends StatefulWidget {
  const ChartCheckboxesWidget({super.key});

  @override
  State<ChartCheckboxesWidget> createState() => _ChartCheckboxesWidgetState();
}

class _ChartCheckboxesWidgetState extends State<ChartCheckboxesWidget> {
  @override
  Widget build(BuildContext context) {
    bool showCalories = context.select((ChartState s) => s.showCalories.value);
    bool showGlucids = context.select((ChartState s) => s.showGlucids.value);
    bool showLipids = context.select((ChartState s) => s.showLipids.value);
    bool showProteins = context.select((ChartState s) => s.showProteins.value);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Row(
            children: [
              Checkbox(
                value: showCalories,
                onChanged: (value) {
                  chartState.showCalories.value =
                      !chartState.showCalories.value;
                },
                activeColor: style.macroColors.calories,
              ),
              Text(
                "calories",
                style: style.fontsize.xxs.merge(style.text.neutral),
              ),
            ],
          ),
          Row(
            children: [
              Checkbox(
                value: showProteins,
                onChanged: (value) {
                  chartState.showProteins.value =
                      !chartState.showProteins.value;
                },
                activeColor: style.macroColors.proteins,
              ),
              Text(
                "protéines",
                style: style.fontsize.xxs.merge(style.text.neutral),
              ),
            ],
          ),
          Row(
            children: [
              Checkbox(
                value: showGlucids,
                onChanged: (value) {
                  chartState.showGlucids.value = !chartState.showGlucids.value;
                },
                activeColor: style.macroColors.glucids,
              ),
              Text(
                "glucides",
                style: style.fontsize.xxs.merge(style.text.neutral),
              ),
            ],
          ),
          Row(
            children: [
              Checkbox(
                value: showLipids,
                onChanged: (value) {
                  chartState.showLipids.value = !chartState.showLipids.value;
                },
                activeColor: style.macroColors.lipids,
              ),
              Text(
                "lipids",
                style: style.fontsize.xxs.merge(style.text.neutral),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
