import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kali/client/layout/Base.scaffold.dart';
import 'package:kali/client/screens/Home.screen.dart';
import 'package:kali/client/widgets/CustomCard.widget.dart';
import 'package:kali/client/widgets/CustomInkwell.widget.dart';
import 'package:kali/client/widgets/LoaderIcon.widget.dart';
import 'package:kali/client/widgets/MealPeriodsHorizontal.widget.dart';
import 'package:kali/client/widgets/MealRow.widget.dart';
import 'package:kali/client/widgets/SlidableItem.widget.dart';
import 'package:kali/client/widgets/WeekJourney.widget.dart';
import 'package:kali/core/actions/Goto.actions.dart';
import 'package:kali/core/domains/meal.service.dart';
import 'package:kali/core/models/MealPeriod.enum.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/states/meal.state.dart';
import 'package:kali/core/models/Meal.model.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';

Future<void> onRemoveMeal(MealModel meal) async {
  try {
    await MealService().deleteMeal(meal.id);
    await MealService().refreshMeals(force: true);
  } catch (e) {
    errorService.notifyError(e: e);
  }
}

class MealsScreen extends StatefulWidget {
  const MealsScreen({super.key});

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      mealState.currentMealPeriods.value = [];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<MealModel> currentMealsByPeriods =
        context.watch<MealState>().currentMealsByPeriods;
    List<MealPeriodEnum> currentMealPeriods =
        context.watch<MealState>().currentMealPeriods.value;
    bool isLoadingDate = context.select((MealState s) => s.isLoadingDate);

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
              WeekJourneyWidget(),

              SizedBox(height: 24),
              MealPeriodsHorizontalWidget(
                onClickSelectPeriod: (period) {
                  onClickSelectPeriod(period);
                },
                chosenPeriods: currentMealPeriods,
              ),
              SizedBox(height: 24),
              if (currentMealsByPeriods.isNotEmpty)
                isLoadingDate
                    ? LoaderIcon()
                    : Expanded(
                      child: ListView.separated(
                        itemCount: currentMealsByPeriods.length,
                        separatorBuilder:
                            (context, index) => SizedBox(height: 4),
                        itemBuilder: (BuildContext context, int index) {
                          final meal = currentMealsByPeriods[index];
                          return CustomInkwell(
                            onTap: () {
                              HapticFeedback.vibrate();
                              goToMealScreen(meal);
                            },
                            child: CustomCard(
                              child: SlidableItem(
                                onRemove: () {
                                  onRemoveMeal(meal);
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 16,
                                  ),
                                  child: MealRowWidget(meal: meal),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
              if (currentMealsByPeriods.isEmpty)
                isLoadingDate
                    ? LoaderIcon()
                    : Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "Pas de repas trouvé",
                        style: style.fontsize.sm,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
