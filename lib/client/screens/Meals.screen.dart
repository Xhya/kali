import 'package:flutter/material.dart';
import 'package:kalori/client/layout/Title.scaffold.dart';
import 'package:kalori/client/widgets/MealRow.widget.dart';
import 'package:kalori/core/domains/meal.state.dart';
import 'package:kalori/core/models/Meal.model.dart';
import 'package:provider/provider.dart';
import 'package:kalori/client/Style.service.dart';
import 'package:kalori/client/layout/Base.scaffold.dart';

class MealsScreen extends StatefulWidget {
  const MealsScreen({super.key});

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  @override
  Widget build(BuildContext context) {
    List<MealModel> meals = context.watch<MealState>().userMeals.value;

    return TitleScaffold(
      title: "Repas",
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: style.background.neutral.color,
          padding: EdgeInsets.all(16),
          child: ListView.builder(
            itemCount: meals.length,
            itemBuilder: (BuildContext context, int index) {
              final meal = meals[index];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: MealRowWidget(meal: meal),
              );
            },
          ),
        ),
      ),
    );
  }
}
