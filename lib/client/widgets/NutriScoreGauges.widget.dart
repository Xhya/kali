import 'package:flutter/material.dart';
import 'package:kalori/client/Style.service.dart';
import 'package:kalori/core/domains/editMeal.state.dart';
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
    NutriScore? editingNutriScore =
        context.watch<EditMealState>().editingNutriScore.value;

    if (currentNutriScore != null && maxNutriScore != null) {
      return Column(
        children: [
          Transform.translate(
            offset: Offset(0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      t('proteins'),
                      style: style.fontsize.md.merge(style.text.neutral),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "${maxNutriScore.proteinAmount}g",
                      style: style.fontsize.sm.merge(style.text.neutral),
                    ),
                    SizedBox(height: 12),
                    SizedBox(
                      height: 100,
                      child: GaugeWidget(
                        currentAmount: currentNutriScore.proteinAmount.toInt(),
                        maxAmount: maxNutriScore.proteinAmount.toInt(),
                        editingAmount: editingNutriScore?.proteinAmount.toInt(),
                      ),
                    ),
                    Text(
                      "${currentNutriScore.proteinAmount}g",
                      style: style.fontsize.sm.merge(style.text.neutral),
                    ),
                    Text(
                      "(${((currentNutriScore.proteinAmount / maxNutriScore.proteinAmount) * 100)}%)",
                      style: style.fontsize.sm.merge(style.text.neutral),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      t('lipids'),
                      style: style.fontsize.md.merge(style.text.neutral),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "${maxNutriScore.lipidAmount}g",
                      style: style.fontsize.sm.merge(style.text.neutral),
                    ),
                    SizedBox(height: 12),
                    SizedBox(
                      height: 100,
                      child: GaugeWidget(
                        currentAmount: currentNutriScore.lipidAmount.toInt(),
                        maxAmount: maxNutriScore.lipidAmount.toInt(),
                        editingAmount: editingNutriScore?.lipidAmount.toInt(),
                      ),
                    ),
                    Text(
                      "${currentNutriScore.lipidAmount}g",
                      style: style.fontsize.sm.merge(style.text.neutral),
                    ),
                    Text(
                      "(${((currentNutriScore.lipidAmount / maxNutriScore.lipidAmount) * 100)}%)",
                      style: style.fontsize.sm.merge(style.text.neutral),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      t('glucids'),
                      style: style.fontsize.md.merge(style.text.neutral),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "${maxNutriScore.glucidAmount}g",
                      style: style.fontsize.sm.merge(style.text.neutral),
                    ),
                    SizedBox(height: 12),
                    SizedBox(
                      height: 100,
                      child: GaugeWidget(
                        currentAmount: currentNutriScore.glucidAmount.toInt(),
                        maxAmount: maxNutriScore.glucidAmount.toInt(),
                        editingAmount: editingNutriScore?.glucidAmount.toInt(),
                      ),
                    ),
                    Text(
                      "${currentNutriScore.glucidAmount}g",
                      style: style.fontsize.sm.merge(style.text.neutral),
                    ),
                    Text(
                      "(${((currentNutriScore.glucidAmount / maxNutriScore.glucidAmount) * 100)}%)",
                      style: style.fontsize.sm.merge(style.text.neutral),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
