import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kali/client/widgets/EndOfTestPeriod.widget.dart';
import 'package:kali/client/widgets/TestPeriodBottomSheet.widget.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/states/configuration.state.dart';
import 'package:kali/core/states/user.state.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/widgets/CustomCard.widget.dart';
import 'package:kali/client/widgets/CustomInkwell.widget.dart';
import 'package:kali/client/widgets/DateSelector.widget.dart';
import 'package:kali/client/widgets/MainKaloriesCount.widget.dart';
import 'package:kali/client/widgets/MealPeriodsHorizontal.widget.dart';
import 'package:kali/client/widgets/MealRow.widget.dart';
import 'package:kali/client/widgets/NutriScoreGauges.widget.dart';
import 'package:kali/client/widgets/QuickAddMealButton.widget.dart';
import 'package:kali/core/actions/Goto.actions.dart';
import 'package:kali/core/domains/meal.service.dart';
import 'package:kali/core/states/meal.state.dart';
import 'package:kali/core/models/Meal.model.dart';
import 'package:kali/core/models/MealPeriod.enum.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/layout/Base.scaffold.dart';

Future<void> initHomeScreen() async {
  try {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    await MealService().refreshMeals();
  } catch (e, stack) {
    errorService.notifyError(e: e, stack: stack);
  }
}

void onClickSelectPeriod(MealPeriodEnum? period) {
  final periods = mealState.currentMealPeriods.value;
  if (period == null) {
    mealState.currentMealPeriods.value = [];
  } else if (periods.contains(period)) {
    mealState.currentMealPeriods.value = [...periods.where((f) => f != period)];
  } else {
    mealState.currentMealPeriods.value = [...periods, period];
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    navigationService.context = context;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initHomeScreen();
      if (userState.user.value?.isInTestPeriod() == true &&
          configurationState.subscriptionActivated.value) {
        navigationService.context = context;
        navigationService.openBottomSheet(
          widget: TestPeriodBottomSheetWidget(),
        );
      }
    });
    super.initState();
    mealState.currentDate.addListener(MealService().refreshMeals);
  }

  @override
  void dispose() {
    mealState.currentDate.removeListener(MealService().refreshMeals);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<MealModel> currentMealsByPeriods =
        context.watch<MealState>().currentMealsByPeriods;
    DateTime currentDate = context.select((MealState s) => s.currentDate.value);
    List<MealPeriodEnum> currentMealPeriods =
        context.watch<MealState>().currentMealPeriods.value;
    MealModel? lastMeal =
        context.watch<MealState>().currentMealsByPeriods.isNotEmpty
            ? currentMealsByPeriods.last
            : null;

    return BaseScaffold(
      profileButton: true,
      child: Scaffold(
        backgroundColor: style.background.greenTransparent.color,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              EndOfTestPeriodWidget(padding: 16),
              DateSelector(currentDate: currentDate),
              SizedBox(height: 16),
              MealPeriodsHorizontalWidget(
                onClickSelectPeriod: (period) {
                  onClickSelectPeriod(period);
                },
                chosenPeriods: currentMealPeriods,
              ),
              SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),

                      MainKaloriesCountWidget(),

                      SizedBox(height: 4),

                      NutriScoreGaugesWidget(
                        mealsByPeriods: currentMealsByPeriods,
                      ),

                      SizedBox(height: 32),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (lastMeal != null)
                            Text(
                              "Derniers ajouts",
                              style: style.fontsize.xs.merge(
                                style.text.greenDark,
                              ),
                            ),
                          if (lastMeal != null)
                            CustomInkwell(
                              onTap: () {
                                HapticFeedback.vibrate();
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
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          child: MealRowWidget(meal: lastMeal),
                        ),
                      SizedBox(height: 120),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Column(
          spacing: 12,
          mainAxisSize: MainAxisSize.min,
          children: [QuickAddMealButtonWidget()],
        ),
      ),
    );
  }
}
