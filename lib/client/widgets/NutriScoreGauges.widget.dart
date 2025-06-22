import 'package:flutter/material.dart';
import 'package:kalori/client/widgets/Gauge.widget.dart';
import 'package:kalori/core/models/NutriScore.model.dart';
import 'package:kalori/core/services/Translation.service.dart';

class NutriScoreGaugesWidget extends StatefulWidget {
  const NutriScoreGaugesWidget({super.key, required this.nutriScore});

  final NutriScore nutriScore;

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
            GaugeWidget(percentage: widget.nutriScore.proteinAmount.toDouble()),
            Text("${widget.nutriScore.proteinAmount.toString()}g"),
          ],
        ),
        Column(
          children: [
            Text(t('lipids')),
            SizedBox(height: 12),
            GaugeWidget(percentage: widget.nutriScore.lipidAmount.toDouble()),
            Text("${widget.nutriScore.lipidAmount.toString()}g"),
          ],
        ),
        Column(
          children: [
            Text(t('glucids')),
            SizedBox(height: 12),
            GaugeWidget(percentage: widget.nutriScore.glucidAmount.toDouble()),
            Text("${widget.nutriScore.glucidAmount.toString()}g"),
          ],
        ),
      ],
    );
  }
}
