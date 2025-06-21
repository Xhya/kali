import 'package:flutter/material.dart';
import 'package:kalori/client/widgets/Gauge.widget.dart';
import 'package:kalori/core/models/NutriScore.model.dart';
import 'package:kalori/core/services/Translation.service.dart';
import 'package:provider/provider.dart';
import 'package:kalori/client/widgets/QuickAddMeal.widget.dart';
import 'package:kalori/client/Style.service.dart';
import 'package:kalori/client/layout/Base.scaffold.dart';
import 'package:kalori/core/domains/nutriScore.state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    NutriScore? nutriScore =
        context.watch<NutriScoreState>().currentNutriScore.value;

    return BaseScaffold(
      child: Scaffold(
        body: Container(
          color: style.background.neutral.color,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child:
                    nutriScore == null
                        ? SizedBox.expand()
                        : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(t('proteins')),
                                SizedBox(height: 12),
                                GaugeWidget(
                                  percentage:
                                      nutriScore.proteinAmount.toDouble(),
                                ),
                                Text("${nutriScore.proteinAmount.toString()}g"),
                              ],
                            ),
                            Column(
                              children: [
                                Text(t('lipids')),
                                SizedBox(height: 12),
                                GaugeWidget(
                                  percentage: nutriScore.lipidAmount.toDouble(),
                                ),
                                Text("${nutriScore.glucidAmount.toString()}g"),
                              ],
                            ),
                            Column(
                              children: [
                                Text(t('glucids')),
                                SizedBox(height: 12),
                                GaugeWidget(
                                  percentage:
                                      nutriScore.glucidAmount.toDouble(),
                                ),
                                Text("${nutriScore.glucidAmount.toString()}g"),
                              ],
                            ),
                          ],
                        ),
              ),
              QuickAddMealWidget(),
            ],
          ),
        ),
      ),

      //       Container(
      //   color: style.background.color1.color,
      //   padding: EdgeInsets.all(16),
      //   child: Column(
      //     mainAxisSize: MainAxisSize.max,
      //     children: [
      //       TextField(
      //         controller: _controller,
      //         decoration: const InputDecoration(
      //           border: UnderlineInputBorder(),
      //           labelText: 'Enter your username',
      //         ),
      //       ),
      //       ButtonWidget(
      //         onPressed: () async {
      //           await computeNutriScore(_controller.text);
      //         },
      //       ),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
      //         children: [
      //           if (nutriScore?.proteinAmount != null)
      //             Column(
      //               children: [
      //                 Text("Protéines"),
      //                 Text(nutriScore!.proteinAmount.toString()),
      //               ],
      //             ),
      //           if (nutriScore?.lipidAmount != null)
      //             Column(
      //               children: [
      //                 Text("Lipides"),
      //                 Text(nutriScore!.lipidAmount.toString()),
      //               ],
      //             ),
      //           if (nutriScore?.glucidAmount != null)
      //             Column(
      //               children: [
      //                 Text("Glucides"),
      //                 Text(nutriScore!.glucidAmount.toString()),
      //               ],
      //             ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
