import 'package:flutter/material.dart';
import 'package:kalori/client/layout/Title.scaffold.dart';
import 'package:kalori/client/widgets/MealRow.widget.dart';
import 'package:kalori/client/widgets/NutriScoreGauges.widget.dart';
import 'package:kalori/core/domains/meal.state.dart';
import 'package:kalori/core/models/Meal.model.dart';
import 'package:kalori/core/services/Error.service.dart';
import 'package:kalori/core/services/Translation.service.dart';
import 'package:provider/provider.dart';
import 'package:kalori/client/Style.service.dart';

class MealScreen extends StatefulWidget {
  const MealScreen({super.key});

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  @override
  Widget build(BuildContext context) {
    MealModel? meal = context.watch<MealState>().currentMeal.value;

    if (meal == null) {
      errorService.notifyError("Missing meal");
      return SizedBox.shrink();
    }

    return TitleScaffold(
      title: t("meal"),
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: style.background.neutral.color,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [MealRowWidget(meal: meal), NutriScoreGaugesWidget()],
          ),
        ),
      ),
    );
  }
}
