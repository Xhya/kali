import 'package:flutter/material.dart';
import 'package:kalori/client/states/quickAddMeal.state.dart';
import 'package:kalori/client/widgets/CustomCard.widget.dart';
import 'package:kalori/client/widgets/CustomInkwell.widget.dart';
import 'package:kalori/client/widgets/MainKaloriesCount.widget.dart';
import 'package:kalori/client/widgets/NutriScoreGauges.widget.dart';
import 'package:kalori/core/actions/Goto.actions.dart';
import 'package:kalori/core/domains/meal.service.dart';
import 'package:kalori/core/domains/meal.state.dart';
import 'package:kalori/core/domains/nutriScore.service.dart';
import 'package:kalori/core/domains/nutriScore.state.dart';
import 'package:kalori/core/models/Meal.model.dart';
import 'package:kalori/core/models/MealPeriod.enum.dart';
import 'package:kalori/core/models/NutriScore.model.dart';
import 'package:kalori/core/services/Error.service.dart';
import 'package:kalori/core/services/Navigation.service.dart';
import 'package:kalori/core/services/Translation.service.dart';
import 'package:kalori/core/utils/computeDayAverages.utils.dart';
import 'package:provider/provider.dart';
import 'package:kalori/client/widgets/QuickAddMeal.widget.dart';
import 'package:kalori/client/Style.service.dart';
import 'package:kalori/client/layout/Base.scaffold.dart';

initHomeScreen() async {
  try {
    await refreshMeals();
    computeDayAverages();
    await refreshPersonalNutriScore();
  } catch (e) {
    errorService.notifyError(e);
  }
}

onClickAddQuickMeal() {
  quickAddMealState.reset();
  navigationService.openBottomSheet(widget: QuickAddMealWidget());
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
    super.initState();
    initHomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    List<MealModel> meals = context.watch<MealState>().userMeals.value;
    NutriScore? currentNutriScore =
        context.watch<NutriScoreState>().currentNutriScore.value;

    final lastMeal = meals.isNotEmpty ? meals.last : null;

    return BaseScaffold(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: style.background.color1.color,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainKaloriesCountWidget(),
                SizedBox(height: 24),
                CustomCard(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (currentNutriScore?.caloryAmount != null)
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: style.text.reverse_neutral.merge(
                                style.fontsize.md,
                              ),
                              children: [
                                TextSpan(text: 'Bravo, '),
                                TextSpan(
                                  text:
                                      '${currentNutriScore!.caloryAmount} kcal',
                                  style: style.fontweight.bold,
                                ),
                                TextSpan(text: ' dépensées !'),
                              ],
                            ),
                          ),

                        Text(
                          "🔥",
                          style: style.text.reverse_neutral.merge(
                            style.fontsize.md,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // if (lastMeal != null)
                //   GestureDetector(
                //     onTap: () {
                //       goToMealScreen(lastMeal);
                //     },
                //     child: MealRowWidget(meal: lastMeal),
                //   ),
                if (lastMeal != null)
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          goToMealsScreen();
                        },
                        child: Text(
                          t("see_all"),
                          style: style.fontsize.xs.merge(style.text.color1),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 32),
                NutriScoreGaugesWidget(),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CustomInkwell(
            onTap: () {
              navigationService.context = context;
              onClickAddQuickMeal();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(color: style.border.color.color1.color!),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 12,
                children: [
                  Icon(
                    Icons.add,
                    color: style.icon.color1.color,
                    size: style.fontsize.lg.fontSize,
                  ),
                  Text(
                    t("add_a_meal"),
                    style: style.text.color2.merge(style.fontsize.md),
                  ),
                ],
              ),
            ),
          ),
        ),
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
