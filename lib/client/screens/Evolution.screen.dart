import 'package:flutter/material.dart';
import 'package:kali/client/Utils/DecimalFormatter.utils.dart';
import 'package:kali/client/Utils/MaxDecimalDigitsCountFormatter.utils.dart';
import 'package:kali/client/widgets/CustomCard.widget.dart';
import 'package:kali/client/widgets/CustomInkwell.widget.dart';
import 'package:kali/client/widgets/CustomInput.dart';
import 'package:kali/client/widgets/LoaderIcon.widget.dart';
import 'package:kali/client/widgets/MainButton.widget.dart';
import 'package:kali/client/widgets/SlidableItem.widget.dart';
import 'package:kali/core/domains/chart.service.dart';
import 'package:kali/core/domains/weight.service.dart';
import 'package:kali/core/models/ChartData.model.dart';
import 'package:kali/core/models/Weight.model.dart';
import 'package:kali/core/services/Datetime.extension.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/states/chart.state.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/layout/Base.scaffold.dart';
import 'package:kali/core/states/weight.state.dart';

Future<void> onClickAddWeight() async {
  try {
    weightState.isAddingWeightLoading.value = true;
    await weightService.addWeight();
  } catch (e, stack) {
    errorService.notifyError(e: e, stack: stack);
  } finally {
    weightState.isAddingWeightLoading.value = false;
  }
}

void onClickOpenAddWeight(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Ajouter une pesée"),
        content: IntrinsicHeight(
          child: CustomInput(
            onChanged: (String text) {
              weightState.newWeight.value = double.parse(text);
            },
            inputFormatters: [
              decimalFormatter(),
              MaxDecimalDigitsCountFormatter(
                maxDigitsBeforeDecimal: 3,
                maxDigitsAfterDecimal: 3,
              ),
            ],
            suffixText: "kg",
            textInputAction: TextInputAction.next,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Annuler"),
          ),
          TextButton(
            onPressed: () {
              onClickAddWeight();
              Navigator.of(context).pop();
            },
            child: Text("Ajouter"),
          ),
        ],
      );
    },
  );
}

class EvolutionScreen extends StatefulWidget {
  const EvolutionScreen({super.key});

  @override
  State<EvolutionScreen> createState() => _EvolutionScreenState();
}

class _EvolutionScreenState extends State<EvolutionScreen> {
  @override
  void initState() {
    super.initState();
    chartService.refreshEvolution();
    weightService.refreshWeights();
  }

  @override
  Widget build(BuildContext context) {
    final isRefreshLoading = context.select(
      (ChartState s) => s.isRefreshLoading.value,
    );
    final caloriesData = context.select((ChartState s) => s.caloriesData.value);
    final glucidsData = context.select((ChartState s) => s.glucidsData.value);
    final proteinsData = context.select((ChartState s) => s.proteinsData.value);
    final lipidsData = context.select((ChartState s) => s.lipidsData.value);
    final List<WeightModel> weights = context.select(
      (WeightState s) => s.weights.value,
    );
    final weightData = weights.map((w) => ChartData.fromWeight(w)).toList();

    createSeries({
      required String name,
      required List<ChartData> dataSource,
      required String yAxisName,
      required Color? color,
      bool visibleMark = true,
    }) {
      return SplineSeries<ChartData, String>(
        name: name,
        dataSource: dataSource,
        color: color,
        yAxisName: yAxisName,
        xValueMapper: (ChartData data, _) => data.x,
        yValueMapper: (ChartData data, _) => data.y,
        dataLabelSettings: DataLabelSettings(isVisible: true),
        markerSettings: MarkerSettings(isVisible: visibleMark),
        splineType: SplineType.natural,
      );
    }

    return BaseScaffold(
      backButton: true,
      child: Scaffold(
        backgroundColor: style.background.greenTransparent.color,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          isRefreshLoading
                              ? Container(
                                height: 200,
                                alignment: Alignment.center,
                                child: LoaderIcon(),
                              )
                              : SfCartesianChart(
                                primaryXAxis: CategoryAxis(),
                                legend: Legend(isVisible: true),
                                tooltipBehavior: TooltipBehavior(enable: true),
                                axes: <ChartAxis>[
                                  NumericAxis(
                                    name: 'rightAxis',
                                    opposedPosition: true,
                                    isVisible: false,
                                  ),
                                  NumericAxis(
                                    name: 'rightSecondAxis',
                                    opposedPosition: true,
                                    isVisible: false,
                                  ),
                                ],
                                series: <CartesianSeries<ChartData, String>>[
                                  createSeries(
                                    name: 'Calories',
                                    dataSource: caloriesData,
                                    yAxisName: 'rightAxis',
                                    color: style.macroColors.calories,
                                  ),
                                  createSeries(
                                    name: 'Glucides',
                                    dataSource: glucidsData,
                                    yAxisName: 'rightSecondAxis',
                                    color: style.macroColors.glucids,
                                    visibleMark: false,
                                  ),
                                  createSeries(
                                    name: 'Protéines',
                                    dataSource: proteinsData,
                                    yAxisName: 'rightSecondAxis',
                                    color: style.macroColors.proteins,
                                    visibleMark: false,
                                  ),
                                  createSeries(
                                    name: 'Lipides',
                                    dataSource: lipidsData,
                                    yAxisName: 'rightSecondAxis',
                                    color: style.macroColors.lipids,
                                    visibleMark: false,
                                  ),
                                  SplineSeries<ChartData, String>(
                                    name: 'Poids',
                                    dataSource: weightData,
                                    xValueMapper: (ChartData data, _) => data.x,
                                    yValueMapper: (ChartData data, _) => data.y,
                                    color: Colors.amber,
                                    markerSettings: MarkerSettings(
                                      isVisible: true,
                                    ),
                                    splineType: SplineType.natural,
                                  ),
                                ],
                              ),
                          isRefreshLoading
                              ? Container(
                                height: 200,
                                alignment: Alignment.center,
                                child: LoaderIcon(),
                              )
                              : ListView.separated(
                                shrinkWrap: true,
                                itemCount: weights.length,
                                separatorBuilder:
                                    (context, index) => SizedBox(height: 4),
                                itemBuilder: (BuildContext context, int index) {
                                  final weight = weights[index];
                                  return CustomInkwell(
                                    onTap: () {},
                                    child: CustomCard(
                                      child: SlidableItem(
                                        onRemove: () {},
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 8,
                                            horizontal: 16,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                weight.date.formateDate(
                                                  "EE dd MMM",
                                                ),
                                              ),
                                              Text(
                                                "${weight.value.toString()} kg",
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    right: 24,
                    child: SafeArea(
                      child: MainButtonWidget(
                        onClick: () {
                          onClickOpenAddWeight(context);
                        },
                        text: "+",
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
