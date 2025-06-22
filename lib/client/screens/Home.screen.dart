import 'package:flutter/material.dart';
import 'package:kalori/client/widgets/MealRow.widget.dart';
import 'package:kalori/client/widgets/NutriScoreGauges.widget.dart';
import 'package:kalori/core/actions/nutriScore.actions.dart';
import 'package:kalori/core/domains/meal.state.dart';
import 'package:kalori/core/models/Meal.model.dart';
import 'package:provider/provider.dart';
import 'package:kalori/client/widgets/QuickAddMeal.widget.dart';
import 'package:kalori/client/Style.service.dart';
import 'package:kalori/client/layout/Base.scaffold.dart';

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
    List<MealModel> meals = context.watch<MealState>().userMeals.value;

    final lipidAmountDayAverage = meals.fold(
      0,
      (sum, curr) => sum + (curr.nutriScore?.lipidAmount.toInt() ?? 0),
    );
    final proteinAmountDayAverage = meals.fold(
      0,
      (sum, curr) => sum + (curr.nutriScore?.proteinAmount.toInt() ?? 0),
    );
    final glucidAmountDayAverage = meals.fold(
      0,
      (sum, curr) => sum + (curr.nutriScore?.glucidAmount.toInt() ?? 0),
    );

    final lastMeal = meals.isNotEmpty ? meals.last : null;

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
              if (lastMeal != null) MealRowWidget(meal: lastMeal),
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
