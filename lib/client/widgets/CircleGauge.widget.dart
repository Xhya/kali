import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/core/models/MealPeriod.enum.dart';
import 'package:kali/core/states/meal.state.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CircleGaugeWidget extends StatefulWidget {
  const CircleGaugeWidget({
    super.key,
    required this.maxAmount,
    this.editingAmount,
    this.bars = const {},
    this.textCenter,
  });

  final int maxAmount;
  final int? editingAmount;
  final Map<Color, int> bars;
  final String? textCenter;

  @override
  State<CircleGaugeWidget> createState() => _CircleGaugeWidgetState();
}

class _CircleGaugeWidgetState extends State<CircleGaugeWidget> {
  @override
  Widget build(BuildContext context) {
    List<MealPeriodEnum> selectedPeriods =
        context.watch<MealState>().currentMealPeriods.value;

    if (selectedPeriods.isEmpty) {
      final entry = widget.bars.entries.elementAt(0);

      return SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            startAngle: 180,
            endAngle: 180 + 360,
            minimum: 0,
            maximum: widget.maxAmount.toDouble(),
            showLabels: false,
            showTicks: false,
            axisLineStyle: AxisLineStyle(
              thickness: 0.15,
              cornerStyle: CornerStyle.bothCurve,
              color: style.background.greenDark.color,
              thicknessUnit: GaugeSizeUnit.factor,
            ),
            pointers: <GaugePointer>[
              RangePointer(
                value: entry.value.toDouble(),
                width: 0.15,
                sizeUnit: GaugeSizeUnit.factor,
                color: entry.key,
                cornerStyle: CornerStyle.bothCurve,
                enableAnimation: true,
              ),
            ],
            annotations: <GaugeAnnotation>[
              if (widget.textCenter != null)
                GaugeAnnotation(
                  widget: Text(
                    widget.textCenter!,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        ],
      );
    } else {
      double startValue = 0;

      final list = List.generate(widget.bars.entries.length, (index) {
        final entry = widget.bars.entries.elementAt(index);
        final gauge = GaugeRange(
          startValue: startValue,
          endValue: startValue + entry.value.toDouble(),
          color: entry.key,
          startWidth: 6,
          endWidth: 6,
        );

        startValue = startValue + entry.value.toDouble();

        return gauge;
      });

      return SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            startAngle: 180,
            endAngle: 180 + 360,
            minimum: 0,
            maximum: widget.maxAmount.toDouble(),
            showLabels: false,
            showTicks: false,
            axisLineStyle: AxisLineStyle(
              thickness: 0.15,
              cornerStyle: CornerStyle.bothCurve,
              color: style.background.greenDark.color,
              thicknessUnit: GaugeSizeUnit.factor,
            ),
            pointers: <GaugePointer>[],
            ranges: [
              ...list,

              if (widget.editingAmount != null)
                GaugeRange(
                  startValue: 0,
                  endValue: widget.editingAmount!.toDouble(),
                  color: Colors.blue,
                  startWidth: 5,
                  endWidth: 5,
                ),
            ],
            annotations: <GaugeAnnotation>[
              if (widget.textCenter != null)
                GaugeAnnotation(
                  widget: Text(
                    widget.textCenter!,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        ],
      );
    }
  }
}
