import 'package:flutter/material.dart';
import 'package:kali/core/domains/chart.repository.dart';
import 'package:kali/core/models/ChartData.model.dart';
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
  var data;

  @override
  void initState() {
    super.initState();

    init() async {
      final evolutionData = await ChartRepository().getEvolution();
      if (evolutionData != null) {
        setState(() {
          data = evolutionData;
        });
      }
    }

    init();
  }

  @override
  Widget build(BuildContext context) {
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
                          SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            legend: Legend(isVisible: true),
                            tooltipBehavior: TooltipBehavior(enable: true),
                            series: <CartesianSeries<ChartData, String>>[
                              LineSeries<ChartData, String>(
                                name: 'Quantité calories quotidienne (g)',
                                dataSource: data,
                                xValueMapper: (ChartData sales, _) => sales.x,
                                yValueMapper: (ChartData sales, _) => sales.y,
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
