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
    NutriScore? currentNutriScore =
        context.watch<NutriScoreState>().currentNutriScore.value;
    NutriScore? maxNutriScore =
        context.watch<NutriScoreState>().personalNutriScore.value;

    if (currentNutriScore != null && maxNutriScore != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(t('proteins')),
              SizedBox(height: 12),
              Text("${maxNutriScore.proteinAmount.toStringAsFixed(0)}g"),
              SizedBox(height: 12),
              GaugeWidget(
                currentAmount: currentNutriScore.proteinAmount.toInt(),
                maxAmount: maxNutriScore.proteinAmount.toInt(),
              ),
              Text("${currentNutriScore.proteinAmount.toStringAsFixed(0)}g"),
              Text(
                "(${((currentNutriScore.proteinAmount / maxNutriScore.proteinAmount) * 100).toStringAsFixed(0)}%)",
              ),
            ],
          ),
          Column(
            children: [
              Text(t('lipids')),
              SizedBox(height: 12),
              Text("${maxNutriScore.lipidAmount.toStringAsFixed(0)}g"),
              SizedBox(height: 12),
              GaugeWidget(
                currentAmount: currentNutriScore.lipidAmount.toInt(),
                maxAmount: maxNutriScore.lipidAmount.toInt(),
              ),
              Text("${currentNutriScore.lipidAmount.toStringAsFixed(0)}g"),
              Text(
                "(${((currentNutriScore.lipidAmount / maxNutriScore.lipidAmount) * 100).toStringAsFixed(0)}%)",
              ),
            ],
          ),
          Column(
            children: [
              Text(t('glucids')),
              SizedBox(height: 12),
              Text("${maxNutriScore.glucidAmount.toStringAsFixed(0)}g"),
              SizedBox(height: 12),
              GaugeWidget(
                currentAmount: currentNutriScore.glucidAmount.toInt(),
                maxAmount: maxNutriScore.glucidAmount.toInt(),
              ),
              Text("${currentNutriScore.glucidAmount.toStringAsFixed(0)}g"),
              Text(
                "(${((currentNutriScore.glucidAmount / maxNutriScore.glucidAmount) * 100).toStringAsFixed(0)}%)",
              ),
            ],
          ),
          Column(
            children: [
              Text(t('calories')),
              SizedBox(height: 12),
              Text("${maxNutriScore.caloryAmount.toStringAsFixed(0)}g"),
              SizedBox(height: 12),
              GaugeWidget(
                currentAmount: currentNutriScore.caloryAmount.toInt(),
                maxAmount: maxNutriScore.caloryAmount.toInt(),
              ),
              Text("${currentNutriScore.caloryAmount.toStringAsFixed(0)}g"),
              Text(
                "(${((currentNutriScore.caloryAmount / maxNutriScore.caloryAmount) * 100).toStringAsFixed(0)}%)",
              ),
            ],
          ),
        ],
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
