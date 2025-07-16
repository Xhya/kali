import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CircleGaugeWidget extends StatefulWidget {
  const CircleGaugeWidget({
    super.key,
    required this.maxAmount,
    this.editingAmount,
    this.bars = const {},
  });

  final int maxAmount;
  final int? editingAmount;
  final Map<Color, int> bars;

  @override
  State<CircleGaugeWidget> createState() => _CircleGaugeWidgetState();
}

class _CircleGaugeWidgetState extends State<CircleGaugeWidget> {
  @override
  Widget build(BuildContext context) {
    double startValue = 0;

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
          ranges: [
            ...widget.bars.entries.map((entry) {
              final gauge = GaugeRange(
                startValue: startValue,
                endValue: startValue + entry.value.toDouble(),
                color: entry.key,
                startWidth: 6,
                endWidth: 6,
              );

              startValue = entry.value.toDouble();

              return gauge;
            }),
            if (widget.editingAmount != null)
              GaugeRange(
                startValue: 0,
                endValue: widget.editingAmount!.toDouble(),
                color: Colors.blue,
                startWidth: 5,
                endWidth: 5,
              ),
          ],
        ),
      ],
    );
  }
}
