import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/LoaderIcon.widget.dart';
import 'package:kali/core/models/ChartData.model.dart';
import 'package:kali/core/states/chart.state.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartWidget extends StatefulWidget {
  const ChartWidget({super.key});

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  @override
  Widget build(BuildContext context) {
    final isRefreshLoading = context.select(
      (ChartState s) => s.isRefreshLoading.value,
    );
    final caloriesData = context.select((ChartState s) => s.caloriesData.value);
    final glucidsData = context.select((ChartState s) => s.glucidsData.value);
    final proteinsData = context.select((ChartState s) => s.proteinsData.value);
    final lipidsData = context.select((ChartState s) => s.lipidsData.value);
    final weightData = context.select((ChartState s) => s.weightsData.value);

    bool showCalories = context.select((ChartState s) => s.showCalories.value);
    bool showGlucids = context.select((ChartState s) => s.showGlucids.value);
    bool showLipids = context.select((ChartState s) => s.showLipids.value);
    bool showProteins = context.select((ChartState s) => s.showProteins.value);

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
        dataLabelSettings: DataLabelSettings(isVisible: visibleMark),
        markerSettings: MarkerSettings(isVisible: visibleMark),
        splineType: SplineType.natural,
      );
    }

    return isRefreshLoading
        ? Container(
          height: 200,
          alignment: Alignment.center,
          child: LoaderIcon(),
        )
        : SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          legend: Legend(isVisible: false),
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
            if (showCalories)
              createSeries(
                name: 'Calories',
                dataSource: caloriesData,
                yAxisName: 'rightAxis',
                color: style.macroColors.calories,
              ),
            if (showGlucids)
              createSeries(
                name: 'Glucides',
                dataSource: glucidsData,
                yAxisName: 'rightSecondAxis',
                color: style.macroColors.glucids,
                visibleMark: false,
              ),
            if (showProteins)
              createSeries(
                name: 'Protéines',
                dataSource: proteinsData,
                yAxisName: 'rightSecondAxis',
                color: style.macroColors.proteins,
                visibleMark: false,
              ),

            if (showLipids)
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
              color: Colors.blue,
              markerSettings: MarkerSettings(isVisible: true),
              splineType: SplineType.natural,
            ),
          ],
        );
  }
}
