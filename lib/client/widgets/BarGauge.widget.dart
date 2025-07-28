import 'package:flutter/material.dart';
import 'package:kali/core/models/MealPeriod.enum.dart';
import 'package:kali/core/states/meal.state.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class BarGaugeWidget extends StatefulWidget {
  const BarGaugeWidget({
    super.key,
    required this.maxAmount,
    this.bars = const {},
  });

  final int maxAmount;
  final Map<Color, int> bars;

  @override
  State<BarGaugeWidget> createState() => _BarGaugeWidgetState();
}

class _BarGaugeWidgetState extends State<BarGaugeWidget> {
  @override
  Widget build(BuildContext context) {
    List<MealPeriodEnum> selectedPeriods =
        context.watch<MealState>().currentMealPeriods.value;

    double startValue = 0;

    if (selectedPeriods.isEmpty) {
      final entry = widget.bars.entries.elementAt(0);

      return SfLinearGauge(
        minimum: 0,
        maximum: widget.maxAmount.toDouble(),
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
            value: entry.value.toDouble(),
            color: style.gauge.main.color,
            thickness: 8,
            edgeStyle: LinearEdgeStyle.bothCurve,
          ),
        ],
      );
    } else {
      final list = List.generate(widget.bars.entries.length, (index) {
        final entry = widget.bars.entries.elementAt(index);
        final gauge = LinearGaugeRange(
          startValue: startValue,
          endValue: startValue + entry.value.toDouble(),
          color: entry.key,
          startWidth: 8,
          endWidth: 8,
          edgeStyle:
              widget.bars.length == 1
                  ? LinearEdgeStyle.bothCurve
                  : index == 0
                  ? LinearEdgeStyle.startCurve
                  : index == widget.bars.length - 1
                  ? LinearEdgeStyle.endCurve
                  : LinearEdgeStyle.bothFlat,
        );

        startValue = entry.value.toDouble();

        return gauge;
      });

      return SfLinearGauge(
        minimum: 0,
        maximum: widget.maxAmount.toDouble(),
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
        ranges: list,
      );
    }
  }
}
