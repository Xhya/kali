import 'package:flutter/material.dart';
import 'package:kalori/core/domains/nutriScore.state.dart';
import 'package:kalori/core/models/NutriScore.model.dart';
import 'package:provider/provider.dart';
import 'package:kalori/client/widgets/Gauge.widget.dart';
import 'package:kalori/core/services/Translation.service.dart';

class NutriScoreGaugesWidget extends StatefulWidget {
  const NutriScoreGaugesWidget({super.key});

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
    NutriScore? nutriScore =
        context.watch<NutriScoreState>().currentNutriScore.value;

    if (nutriScore != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(t('proteins')),
              SizedBox(height: 12),
              GaugeWidget(percentage: nutriScore.proteinAmount.toDouble()),
              Text("${nutriScore.proteinAmount.toString()}g"),
            ],
          ),
          Column(
            children: [
              Text(t('lipids')),
              SizedBox(height: 12),
              GaugeWidget(percentage: nutriScore.lipidAmount.toDouble()),
              Text("${nutriScore.lipidAmount.toString()}g"),
            ],
          ),
          Column(
            children: [
              Text(t('glucids')),
              SizedBox(height: 12),
              GaugeWidget(percentage: nutriScore.glucidAmount.toDouble()),
              Text("${nutriScore.glucidAmount.toString()}g"),
            ],
          ),
          Column(
            children: [
              Text(t('calories')),
              SizedBox(height: 12),
              GaugeWidget(percentage: nutriScore.caloryAmount.toDouble()),
              Text("${nutriScore.caloryAmount.toString()}g"),
            ],
          ),
        ],
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
