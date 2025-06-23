import 'package:flutter/material.dart';
import 'package:kalori/client/states/quickAddMeal.state.dart';
import 'package:kalori/client/widgets/CustomButton.widget.dart';
import 'package:kalori/client/widgets/MealRow.widget.dart';
import 'package:kalori/client/widgets/NutriScoreGauges.widget.dart';
import 'package:kalori/core/actions/Goto.actions.dart';
import 'package:kalori/core/actions/nutriScore.actions.dart';
import 'package:kalori/core/domains/meal.state.dart';
import 'package:kalori/core/models/Meal.model.dart';
import 'package:kalori/core/services/Navigation.service.dart';
import 'package:kalori/core/services/Translation.service.dart';
import 'package:provider/provider.dart';
import 'package:kalori/client/widgets/QuickAddMeal.widget.dart';
import 'package:kalori/client/Style.service.dart';
import 'package:kalori/client/layout/Base.scaffold.dart';

onOpenQuickAddMode() {
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

    final lastMeal = meals.isNotEmpty ? meals.last : null;

    return BaseScaffold(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (lastMeal != null)
                  GestureDetector(
                    onTap: () {
                      goToMealScreen(lastMeal);
                    },
                    child: MealRowWidget(meal: lastMeal),
                  ),
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
                          style: style.fontsize.xs.merge(style.text.color4),
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
        floatingActionButton: ButtonWidget(
          text: "+",
          onPressed: () async {
            navigationService.context = context;
            onOpenQuickAddMode();
          },
          buttonType: ButtonTypeEnum.filled,
        ),
      ),
    );
  }
}
