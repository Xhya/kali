import 'package:flutter/material.dart';
import 'package:kali/client/states/quickAddMeal.state.dart';
import 'package:kali/client/widgets/CustomCard.widget.dart';
import 'package:kali/client/widgets/CustomInkwell.widget.dart';
import 'package:kali/client/widgets/DateSelector.widget.dart';
import 'package:kali/client/widgets/MainKaloriesCount.widget.dart';
import 'package:kali/client/widgets/MealRow.widget.dart';
import 'package:kali/client/widgets/NutriScoreGauges.widget.dart';
import 'package:kali/client/widgets/QuickAddMealButton.widget.dart';
import 'package:kali/core/actions/Goto.actions.dart';
import 'package:kali/core/domains/meal.service.dart';
import 'package:kali/core/domains/meal.state.dart';
import 'package:kali/core/domains/nutriScore.service.dart';
import 'package:kali/core/models/Meal.model.dart';
import 'package:kali/core/models/MealPeriod.enum.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/utils/computeDayAverages.utils.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/widgets/QuickAddMeal.widget.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/layout/Base.scaffold.dart';

initHomeScreen() async {
  try {
    await refreshMeals();
    computeDayAverages();
    await refreshPersonalNutriScore();
  } catch (e, stack) {
    errorService.notifyError(e: e, stack: stack);
  }
}

onClickPeriodToQuickAddMeal({MealPeriodEnum? period}) {
  quickAddMealState.chosenPeriod.value = period;
  quickAddMealState.userMealText.value = "";
  navigationService.openBottomSheet(widget: QuickAddMealWidget());
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initHomeScreen();
    });
    super.initState();
    mealState.currentDate.addListener(refreshMeals);
  }

  @override
  void dispose() {
    mealState.currentDate.removeListener(refreshMeals);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<MealModel> meals = context.watch<MealState>().currentMeals.value;
    DateTime currentDate = context.watch<MealState>().currentDate.value;

    final lastMeal = meals.isNotEmpty ? meals.last : null;

    return BaseScaffold(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: style.background.greenTransparent.color,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DateSelector(currentDate: currentDate),

                SizedBox(height: 24),
                
                MainKaloriesCountWidget(),

                SizedBox(height: 4),

                NutriScoreGaugesWidget(meals: meals),

                SizedBox(height: 32),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Derniers ajouts",
                      style: style.fontsize.xs.merge(style.text.greenDark),
                    ),
                    if (lastMeal != null)
                      CustomInkwell(
                        onTap: () {
                          goToMealsScreen();
                        },
                        child: Text(
                          "Afficher tout",
                          style: style.fontsize.xs
                              .merge(style.text.green)
                              .merge(style.fontweight.bold),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 8),
                if (lastMeal != null)
                  CustomCard(
                    onClick: () {
                      goToMealScreen(lastMeal);
                    },
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: MealRowWidget(meal: lastMeal),
                  ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: QuickAddMealButtonWidget(),
      ),

      // bottomSheet:
      // Container(
      //   width: double.infinity,
      //   padding: const EdgeInsets.only(
      //     left: 16,
      //     right: 16,
      //     top: 16,
      //     bottom: 24,
      //   ),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: [
      //       GestureDetector(
      //         onTap: () {
      //           navigationService.context = context;
      //           onClickPeriodToQuickAddMeal(period: MealPeriodEnum.breakfast);
      //         },
      //         child: Text(t("breakfast")),
      //       ),
      //       GestureDetector(
      //         onTap: () {
      //           navigationService.context = context;
      //           onClickPeriodToQuickAddMeal(period: MealPeriodEnum.lunch);
      //         },
      //         child: Text(t("lunch")),
      //       ),
      //       GestureDetector(
      //         onTap: () {
      //           navigationService.context = context;
      //           onClickPeriodToQuickAddMeal(period: MealPeriodEnum.snack);
      //         },
      //         child: Text(t("snack")),
      //       ),
      //       GestureDetector(
      //         onTap: () {
      //           navigationService.context = context;
      //           onClickPeriodToQuickAddMeal(period: MealPeriodEnum.dinner);
      //         },
      //         child: Text(t("dinner")),
      //       ),
      //     ],
      //   ),
      //   //  ButtonWidget(
      //   //   text: "+",
      //   //   onPressed: () async {

      //   //   },
      //   //   buttonType: ButtonTypeEnum.filled,
      //   // ),
      // ),
    );
  }
}
