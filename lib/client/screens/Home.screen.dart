import 'package:flutter/material.dart';
import 'package:kalori/client/widgets/MealPeriodTag.widget.dart';
import 'package:kalori/client/widgets/MealRow.widget.dart';
import 'package:kalori/client/widgets/NutriScoreGauges.widget.dart';
import 'package:kalori/core/actions/nutriScore.actions.dart';
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
  void initState() {
    super.initState();
    initHomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    List<NutriScore> nutriScores =
        context.watch<NutriScoreState>().userNutriScores.value;

    final lipidAmountDayAverage = nutriScores.fold(
      0,
      (sum, curr) => sum + curr.lipidAmount.toInt(),
    );
    final proteinAmountDayAverage = nutriScores.fold(
      0,
      (sum, curr) => sum + curr.proteinAmount.toInt(),
    );
    final glucidAmountDayAverage = nutriScores.fold(
      0,
      (sum, curr) => sum + curr.glucidAmount.toInt(),
    );

    final lastNutriScore = nutriScores.isNotEmpty ? nutriScores.last : null;

    return BaseScaffold(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: style.background.neutral.color,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (lastNutriScore != null)
                MealRowWidget(nutriScore: lastNutriScore),
              SizedBox(height: 32),
              Expanded(
                child: NutriScoreGaugesWidget(
                  lipidAmount: lipidAmountDayAverage,
                  glucidAmount: glucidAmountDayAverage,
                  proteinAmount: proteinAmountDayAverage,
                ),
              ),
              QuickAddMealWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
