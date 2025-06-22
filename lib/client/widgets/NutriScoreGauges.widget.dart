import 'package:flutter/material.dart';
import 'package:kalori/client/widgets/Gauge.widget.dart';
import 'package:kalori/core/services/Translation.service.dart';

class NutriScoreGaugesWidget extends StatefulWidget {
  const NutriScoreGaugesWidget({
    super.key,
    required this.proteinAmount,
    required this.lipidAmount,
    required this.glucidAmount,
  });

  final int proteinAmount;
  final int lipidAmount;
  final int glucidAmount;

  @override
  State<NutriScoreGaugesWidget> createState() => _NutriScoreGaugesWidgetState();
}

class _NutriScoreGaugesWidgetState extends State<NutriScoreGaugesWidget> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Text(t('proteins')),
            SizedBox(height: 12),
            GaugeWidget(percentage: widget.proteinAmount.toDouble()),
            Text("${widget.proteinAmount.toString()}g"),
          ],
        ),
        Column(
          children: [
            Text(t('lipids')),
            SizedBox(height: 12),
            GaugeWidget(percentage: widget.lipidAmount.toDouble()),
            Text("${widget.lipidAmount.toString()}g"),
          ],
        ),
        Column(
          children: [
            Text(t('glucids')),
            SizedBox(height: 12),
            GaugeWidget(percentage: widget.glucidAmount.toDouble()),
            Text("${widget.glucidAmount.toString()}g"),
          ],
        ),
      ],
    );
  }
}
