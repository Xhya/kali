import 'package:flutter/material.dart';
import 'package:kali/client/widgets/TotalCalories.widget.dart';
import 'package:kali/client/widgets/Expanded.widget.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/TotalNutriScores.widget.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Expanded(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12),
              Text(
                "➡ Et voici ton plan personnalisé 🔥",
                style: style.text.neutral.merge(style.fontsize.lg),
              ),

              SizedBox(height: 32),

              ExpandedWidget(
                height: 220,
                child: Column(
                  children: [TotalCaloriesWidget(), SizedBox(height: 4)],
                ),
              ),

              SizedBox(height: 16),

              TotalNutriScoresWidget(),

              // Text(
              //   "Avec ce plan, tu es en léger déficit. Si tu t'y tiens régulièrement, tu perdras environ 400g par semaine.",
              //   style: style.text.neutral.merge(style.fontsize.xs),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
