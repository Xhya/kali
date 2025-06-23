import 'package:flutter/material.dart';
import 'package:kalori/client/Style.service.dart';
import 'package:kalori/core/domains/editMeal.state.dart';
import 'package:kalori/core/domains/nutriScore.state.dart';
import 'package:kalori/core/models/NutriScore.model.dart';
import 'package:provider/provider.dart';
import 'package:kalori/client/widgets/Gauge.widget.dart';
import 'package:kalori/core/services/Translation.service.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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
          Column(
            children: [
              SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    startAngle: 180,
                    endAngle: 0,
                    minimum: 0,
                    maximum: maxNutriScore.caloryAmount,
                    pointers: <GaugePointer>[
                      MarkerPointer(
                        value: currentNutriScore.caloryAmount,
                        color: Colors.amber,
                        markerType: MarkerType.diamond,
                        markerHeight: 30,
                        markerWidth: 30,
                        enableDragging: true,
                      ),
                    ],
                    ranges: <GaugeRange>[
                      GaugeRange(
                        startWidth: 20,
                        endWidth: 20,
                        startValue: 0,
                        endValue: maxNutriScore.caloryAmount / 3,
                        color: Colors.lightBlueAccent,
                      ),
                      GaugeRange(
                        startWidth: 20,
                        endWidth: 20,
                        startValue: maxNutriScore.caloryAmount / 3,
                        endValue: maxNutriScore.caloryAmount,
                        color: Colors.green,
                      ),
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Text(
                          "${currentNutriScore.caloryAmount.toStringAsFixed(0)}kcal",
                          style: style.text.color1.merge(style.fontsize.md),
                        ),
                        angle: 90,
                        positionFactor: 0,
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                "${currentNutriScore.caloryAmount.toStringAsFixed(0)}g",
                style: style.fontsize.sm.merge(style.text.color1),
              ),
              Text(
                "(${((currentNutriScore.caloryAmount / maxNutriScore.caloryAmount) * 100).toStringAsFixed(0)}%)",
                style: style.fontsize.sm.merge(style.text.color1),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    t('proteins'),
                    style: style.fontsize.md.merge(style.text.color1),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "${maxNutriScore.proteinAmount.toStringAsFixed(0)}g",
                    style: style.fontsize.sm.merge(style.text.color1),
                  ),
                  SizedBox(height: 12),
                  GaugeWidget(
                    currentAmount: currentNutriScore.proteinAmount.toInt(),
                    maxAmount: maxNutriScore.proteinAmount.toInt(),
                    editingAmount: editingNutriScore?.proteinAmount.toInt(),
                  ),
                  Text(
                    "${currentNutriScore.proteinAmount.toStringAsFixed(0)}g",
                    style: style.fontsize.sm.merge(style.text.color1),
                  ),
                  Text(
                    "(${((currentNutriScore.proteinAmount / maxNutriScore.proteinAmount) * 100).toStringAsFixed(0)}%)",
                    style: style.fontsize.sm.merge(style.text.color1),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    t('lipids'),
                    style: style.fontsize.md.merge(style.text.color1),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "${maxNutriScore.lipidAmount.toStringAsFixed(0)}g",
                    style: style.fontsize.sm.merge(style.text.color1),
                  ),
                  SizedBox(height: 12),
                  GaugeWidget(
                    currentAmount: currentNutriScore.lipidAmount.toInt(),
                    maxAmount: maxNutriScore.lipidAmount.toInt(),
                    editingAmount: editingNutriScore?.lipidAmount.toInt(),
                  ),
                  Text(
                    "${currentNutriScore.lipidAmount.toStringAsFixed(0)}g",
                    style: style.fontsize.sm.merge(style.text.color1),
                  ),
                  Text(
                    "(${((currentNutriScore.lipidAmount / maxNutriScore.lipidAmount) * 100).toStringAsFixed(0)}%)",
                    style: style.fontsize.sm.merge(style.text.color1),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    t('glucids'),
                    style: style.fontsize.md.merge(style.text.color1),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "${maxNutriScore.glucidAmount.toStringAsFixed(0)}g",
                    style: style.fontsize.sm.merge(style.text.color1),
                  ),
                  SizedBox(height: 12),
                  GaugeWidget(
                    currentAmount: currentNutriScore.glucidAmount.toInt(),
                    maxAmount: maxNutriScore.glucidAmount.toInt(),
                    editingAmount: editingNutriScore?.glucidAmount.toInt(),
                  ),
                  Text(
                    "${currentNutriScore.glucidAmount.toStringAsFixed(0)}g",
                    style: style.fontsize.sm.merge(style.text.color1),
                  ),
                  Text(
                    "(${((currentNutriScore.glucidAmount / maxNutriScore.glucidAmount) * 100).toStringAsFixed(0)}%)",
                    style: style.fontsize.sm.merge(style.text.color1),
                  ),
                ],
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
