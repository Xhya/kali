import 'package:flutter/material.dart';
import 'package:kali/client/widgets/Expanded.widget.dart';
import 'package:kali/client/widgets/MainKaloriesCount.widget.dart';
import 'package:kali/client/widgets/NutriScoreGauges.widget.dart';
import 'package:kali/core/models/meal.fixture.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/core/models/nutriScore.fixture.dart';
import 'package:kali/core/states/nutriScore.state.dart';

class StartFormPageFinal extends StatefulWidget {
  const StartFormPageFinal({super.key});

  @override
  State<StartFormPageFinal> createState() => _StartFormPageFinalState();
}

class _StartFormPageFinalState extends State<StartFormPageFinal> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      nutriScoreState.currentNutriScore.value = fixtureNutriScore1;
      nutriScoreState.personalNutriScore.value = fixtureNutriScore2;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                height: 330,
                child: Column(
                  children: [
                    MainKaloriesCountWidget(),
                    SizedBox(height: 4),
                    NutriScoreGaugesWidget(meals: fixtureMeals),
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
