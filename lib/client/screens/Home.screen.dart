import 'package:flutter/material.dart';
import 'package:kalori/client/widgets/NutriScoreGauges.widget.dart';
import 'package:kalori/core/models/NutriScore.model.dart';
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
                        : NutriScoreGaugesWidget(nutriScore: nutriScore),
              ),
              QuickAddMealWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
