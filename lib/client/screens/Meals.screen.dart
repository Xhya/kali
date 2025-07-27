import 'package:flutter/material.dart';
import 'package:kali/client/layout/Base.scaffold.dart';
import 'package:kali/client/screens/Home.screen.dart';
import 'package:kali/client/widgets/CustomCard.widget.dart';
import 'package:kali/client/widgets/CustomInkwell.widget.dart';
import 'package:kali/client/widgets/DateSelector.widget.dart';
import 'package:kali/client/widgets/MealPeriodsHorizontal.widget.dart';
import 'package:kali/client/widgets/MealRow.widget.dart';
import 'package:kali/core/actions/Goto.actions.dart';
import 'package:kali/core/models/MealPeriod.enum.dart';
import 'package:kali/core/states/meal.state.dart';
import 'package:kali/core/models/Meal.model.dart';
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
    List<MealModel> currentMealsByPeriods =
        context.watch<MealState>().currentMealsByPeriods;
    DateTime currentDate = context.select((MealState s) => s.currentDate.value);
    List<MealPeriodEnum> currentMealPeriods =
        context.watch<MealState>().currentMealPeriods.value;

    return BaseScaffold(
      backButton: true,
      child: Scaffold(
        backgroundColor: style.background.greenTransparent.color,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(height: 10),
              DateSelector(currentDate: currentDate, canNavigate: false),
              SizedBox(height: 24),
              MealPeriodsHorizontalWidget(
                onClickSelectPeriod: (period) {
                  onClickSelectPeriod(period);
                },
                chosenPeriods: currentMealPeriods,
              ),
              SizedBox(height: 24),
              Expanded(
                child: ListView.separated(
                  itemCount: currentMealsByPeriods.length,
                  separatorBuilder: (context, index) => SizedBox(height: 4),
                  itemBuilder: (BuildContext context, int index) {
                    final meal = currentMealsByPeriods[index];
                    return CustomInkwell(
                      onTap: () {
                        goToMealScreen(meal);
                      },
                      child: CustomCard(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          child: MealRowWidget(meal: meal),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
