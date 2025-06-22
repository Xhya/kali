import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GaugeWidget extends StatefulWidget {
  const GaugeWidget({
    super.key,
    required this.currentAmount,
    required this.maxAmount,
  });

  final int currentAmount;
  final int maxAmount;

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
        borderColor: Colors.black,
      ),
      barPointers: [
        LinearBarPointer(
          value: widget.currentAmount.toDouble(),
          color: Colors.green,
          thickness: 15,
          edgeStyle: LinearEdgeStyle.bothCurve,
        ),
      ],
    );
  }
}
