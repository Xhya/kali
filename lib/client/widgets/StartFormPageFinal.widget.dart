import 'package:flutter/material.dart';
import 'package:kali/core/services/Translation.service.dart';
import 'package:kali/core/utils/macroIcon.utils.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/widgets/CustomCard.widget.dart';
import 'package:kali/client/widgets/Expanded.widget.dart';
import 'package:kali/core/models/NutriScore.model.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/core/states/nutriScore.state.dart';

class StartFormPageFinal extends StatefulWidget {
  const StartFormPageFinal({super.key});

  @override
  State<StartFormPageFinal> createState() => _StartFormPageFinalState();
}

class _StartFormPageFinalState extends State<StartFormPageFinal> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NutriScore? personalNutriScore =
        context.watch<NutriScoreState>().personalNutriScore.value;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Expanded(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12),
              Text(
                "➡ Et voici ton plan sèche 🔥",
                style: style.text.neutral.merge(style.fontsize.lg),
              ),

              SizedBox(height: 32),

              ExpandedWidget(
                height: 220,
                child: Column(
                  children: [
                    CustomCard(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        spacing: 12,
                        children: [
                          Text(
                            "⚖️",
                            textAlign: TextAlign.start,
                            style: style.text.green
                                .merge(style.fontsize.md)
                                .merge(style.fontweight.bold),
                          ),

                          Expanded(
                            child: Text(
                              "calories",
                              textAlign: TextAlign.start,
                              style: style.text.neutral.merge(
                                style.fontsize.sm,
                              ),
                            ),
                          ),
                          if (personalNutriScore?.caloryAmount != null)
                            Text(
                              personalNutriScore!.caloryAmount.toString(),
                              textAlign: TextAlign.start,
                              style: style.text.neutral.merge(
                                style.fontsize.sm,
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      spacing: 4,
                      children: [
                        Expanded(
                          child: CustomCard(
                            child: Column(
                              children: [
                                SizedBox(height: 12),
                                Text(
                                  proteinIcon,
                                  style: style.fontsize.xl.merge(
                                    style.text.neutral,
                                  ),
                                ),
                                Text(
                                  "${personalNutriScore!.proteinAmount}gr",
                                  style: style.fontsize.sm
                                      .merge(style.text.neutral)
                                      .merge(style.fontweight.bold),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  t('proteins').toLowerCase(),
                                  style: style.fontsize.sm.merge(
                                    style.text.neutral,
                                  ),
                                ),
                                SizedBox(height: 12),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: CustomCard(
                            child: Column(
                              children: [
                                SizedBox(height: 12),
                                Text(
                                  lipidIcon,
                                  style: style.fontsize.xl.merge(
                                    style.text.neutral,
                                  ),
                                ),
                                Text(
                                  "${personalNutriScore.glucidAmount}gr",
                                  style: style.fontsize.sm
                                      .merge(style.text.neutral)
                                      .merge(style.fontweight.bold),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  t('glucids').toLowerCase(),
                                  style: style.fontsize.sm.merge(
                                    style.text.neutral,
                                  ),
                                ),
                                SizedBox(height: 12),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: CustomCard(
                            child: Column(
                              children: [
                                SizedBox(height: 12),
                                Text(
                                  glucidIcon,
                                  style: style.fontsize.xl.merge(
                                    style.text.neutral,
                                  ),
                                ),
                                Text(
                                  "${personalNutriScore.lipidAmount}gr",
                                  style: style.fontsize.sm
                                      .merge(style.text.neutral)
                                      .merge(style.fontweight.bold),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  t('lipids').toLowerCase(),
                                  style: style.fontsize.sm.merge(
                                    style.text.neutral,
                                  ),
                                ),
                                SizedBox(height: 12),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),

              Text(
                "Avec ce plan, tu es en léger déficit. Si tu t'y tiens régulièrement, tu perdras environ 400g par semaine.",
                style: style.text.neutral.merge(style.fontsize.xs),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
