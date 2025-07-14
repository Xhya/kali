import 'package:flutter/material.dart';
import 'package:kali/client/layout/Title.scaffold.dart';
import 'package:kali/client/widgets/MealRow.widget.dart';
import 'package:kali/core/actions/Goto.actions.dart';
import 'package:kali/core/domains/meal.state.dart';
import 'package:kali/core/models/Meal.model.dart';
import 'package:kali/core/services/Translation.service.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';

class MealsScreen extends StatefulWidget {
  const MealsScreen({super.key});

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  @override
  Widget build(BuildContext context) {
    List<MealModel> meals = context.watch<MealState>().currentMeals.value;

    return TitleScaffold(
      title: t("meal"),
      child: Scaffold(
        backgroundColor: style.background.greenTransparent.color,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16),
          child: ListView.builder(
            itemCount: meals.length,
            itemBuilder: (BuildContext context, int index) {
              final meal = meals[index];
              return GestureDetector(
                onTap: () {
                  goToMealScreen(meal);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: MealRowWidget(meal: meal),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
