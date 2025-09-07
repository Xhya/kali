import 'package:flutter/material.dart';
import 'package:kali/client/widgets/LoaderIcon.widget.dart';
import 'package:kali/core/domains/chart.service.dart';
import 'package:kali/core/models/ChartData.model.dart';
import 'package:kali/core/states/chart.state.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/layout/Base.scaffold.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    final isRefreshLoading = context.select(
      (ChartState s) => s.isRefreshLoading.value,
    );
    final evolution = context.select((ChartState s) => s.evolution.value);

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
                    child:
                        isRefreshLoading
                            ? Container(
                              height: 200,
                              alignment: Alignment.center,
                              child: LoaderIcon(),
                            )
                            : Container(
                              width: double.maxFinite,
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SfCartesianChart(
                                    primaryXAxis: CategoryAxis(),
                                    legend: Legend(isVisible: true),
                                    tooltipBehavior: TooltipBehavior(
                                      enable: true,
                                    ),
                                    series: <
                                      CartesianSeries<ChartData, String>
                                    >[
                                      LineSeries<ChartData, String>(
                                        name:
                                            'Quantité calories quotidienne (g)',
                                        dataSource: evolution,
                                        xValueMapper:
                                            (ChartData sales, _) => sales.x,
                                        yValueMapper:
                                            (ChartData sales, _) => sales.y,
                                        dataLabelSettings: DataLabelSettings(
                                          isVisible: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
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
