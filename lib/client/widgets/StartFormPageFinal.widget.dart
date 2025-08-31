import 'package:flutter/material.dart';
import 'package:kali/client/widgets/CustomCard.widget.dart';
import 'package:kali/core/states/startForm.state.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/widgets/TotalCalories.widget.dart';
import 'package:kali/client/widgets/Expanded.widget.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/TotalNutriScores.widget.dart';
import 'package:kali/core/models/NutriScore.model.dart';

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
        context.watch<StartFormState>().personalNutriScore.value;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
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

            if (personalNutriScore != null)
              ExpandedWidget(
                height: 250,
                child: Column(
                  children: [
                    TotalCaloriesWidget(nutriScore: personalNutriScore),
                    SizedBox(height: 4),
                    TotalNutriScoresWidget(nutriScore: personalNutriScore),
                    SizedBox(height: 16),
                  ],
                ),
              ),

            Text(
              "Psst : Kali s’adapte ! Tu pourras modifier ton plan à tout moment dans tes paramètres.",
            ),
          ],
        ),
      ),
    );
  }
}
