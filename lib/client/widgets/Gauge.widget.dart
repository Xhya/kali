import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GaugeWidget extends StatefulWidget {
  const GaugeWidget({
    super.key,
    required this.currentAmount,
    required this.maxAmount,
    this.editingAmount,
    this.bars = const {},
  });

  final int currentAmount;
  final int maxAmount;
  final int? editingAmount;
  final Map<Color, int> bars;

  @override
  State<GaugeWidget> createState() => _GaugeWidgetState();
}

class _GaugeWidgetState extends State<GaugeWidget> {
  @override
  Widget build(BuildContext context) {
    return SfLinearGauge(
      minimum: 0,
      maximum: widget.maxAmount.toDouble(),
      showLabels: false,
      showTicks: false,
      orientation: LinearGaugeOrientation.vertical,
      majorTickStyle: LinearTickStyle(length: 20),
      axisLabelStyle: TextStyle(fontSize: 12.0, color: Colors.black),
      axisTrackStyle: LinearAxisTrackStyle(
        edgeStyle: LinearEdgeStyle.bothCurve,
        thickness: 15.0,
        color: style.background.color3.color,
        borderColor: Colors.black,
      ),
      barPointers: [
        // LinearBarPointer(
        //   value: 80,
        //   color: Colors.red,
        //   thickness: 15,
        //   edgeStyle: LinearEdgeStyle.bothCurve,
        // ),
        // LinearBarPointer(
        //   value: 40,
        //   color: Colors.amber,
        //   thickness: 15,
        //   edgeStyle: LinearEdgeStyle.bothCurve,
        // ),
        ...widget.bars.entries.map((entry) {
          return LinearBarPointer(
            value: entry.value.toDouble(),
            color: entry.key,
            thickness: 15,
            edgeStyle: LinearEdgeStyle.bothCurve,
          );
        }),
        // LinearBarPointer(
        //   value: widget.currentAmount.toDouble(),
        //   color: style.gauge.main.color,
        //   thickness: 15,
        //   edgeStyle: LinearEdgeStyle.bothCurve,
        // ),
        if (widget.editingAmount != null)
          LinearBarPointer(
            value: widget.editingAmount!.toDouble(),
            color: Colors.blue,
            thickness: 5,
            edgeStyle: LinearEdgeStyle.bothCurve,
          ),
      ],
    );
  }
}
