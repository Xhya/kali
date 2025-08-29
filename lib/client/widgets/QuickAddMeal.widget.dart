import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/Expanded.widget.dart';
import 'package:kali/client/widgets/MainButton.widget.dart';
import 'package:kali/client/widgets/MealComputerInput.widget.dart';
import 'package:kali/client/widgets/MealPeriodsWrap.widget.dart';
import 'package:kali/client/widgets/NutriScore2by2.widget.dart';
import 'package:kali/client/widgets/QuickAddMealHeader.widget.dart';
import 'package:kali/core/models/MealPeriod.enum.dart';
import 'package:kali/core/models/NutriScore.model.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/states/meal.state.dart';
import 'package:provider/provider.dart';
import 'package:kali/core/states/quickAddMeal.state.dart';
import 'package:kali/core/actions/nutriScore.actions.dart';
import 'package:kali/core/states/Ai.state.dart';

Future<void> onComputeQuickAddMeal() async {
  aiState.aiNotUnderstandError.value = false;
  if (!quickAddMealState.isLoading.value &&
      quickAddMealState.userMealText.value.isNotEmpty &&
      quickAddMealState.chosenPeriod.value != null) {
    await computeNutriScoreAction();
  }
}

void onInputUpdateUserMealText(String value) {
  quickAddMealState.meal.value?.removeNutriScore();
  quickAddMealState.userMealText.value = value;
}

void onClickSelectPeriod(MealPeriodEnum period) {
  quickAddMealState.chosenPeriod.value = period;
}

Future<void> onClickAddMealToDay() async {
  try {
    await addMealAction();
    mealState.currentDate.value = quickAddMealState.date.value;
    quickAddMealState.userMealText.value = "";
    navigationService.closeBottomSheet();
  } catch (e, stack) {
    errorService.notifyError(e: e, stack: stack);
  }
}

class QuickAddMealWidget extends StatefulWidget {
  const QuickAddMealWidget({super.key});

  @override
  State<QuickAddMealWidget> createState() => _QuickAddMealWidgetState();
}

class _QuickAddMealWidgetState extends State<QuickAddMealWidget> {
  @override
  void initState() {
    super.initState();
    quickAddMealState.isLoading.value = false;
    quickAddMealState.date.value = mealState.currentDate.value;

    quickAddMealState.meal.addListener(() {
      final nutri = quickAddMealState.meal.value?.nutriscore;
      if (nutri != null && !quickAddMealState.isExpanded.value) {
        quickAddMealState.isExpanded.value = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    MealPeriodEnum? chosenPeriod = context.select(
      (QuickAddMealState s) => s.chosenPeriod.value,
    );
    NutriScore? nutriScore =
        context.watch<QuickAddMealState>().meal.value?.nutriscore;
    bool computed = context.watch<QuickAddMealState>().computed.value;
    String userMealText = context.select(
      (QuickAddMealState s) => s.userMealText.value,
    );
    bool isLoading = context.select((QuickAddMealState s) => s.isLoading.value);

    return SingleChildScrollView(
      child: Container(
        color: style.background.greenTransparent.color,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              QuickAddMealHeaderWidget(),
              SizedBox(height: 24),
              MealPeriodsWrapWidget(
                onClickSelectPeriod: (MealPeriodEnum period) {
                  onClickSelectPeriod(period);
                },
                chosenPeriod: chosenPeriod,
              ),
              SizedBox(height: 16),

              MealComputerInput(
                mealText: userMealText,
                onUpdate: (value) {
                  onInputUpdateUserMealText(value);
                },
                onCompute: () {
                  onComputeQuickAddMeal();
                },
                isLoading: isLoading,
                disabled: userMealText.isEmpty || chosenPeriod == null,
              ),

              if (computed)
                ExpandedWidget(
                  child: Column(
                    children: [
                      SizedBox(height: 16),
                      Expanded(
                        child: NutriScore2by2Widget(nutriScore: nutriScore),
                      ),
                      SizedBox(height: 16),
                      MainButtonWidget(
                        onClick: () {
                          onClickAddMealToDay();
                        },
                        iconWidget: Icon(Icons.add),
                        text: "Ajouter à la journée",
                        disabled: nutriScore == null,
                      ),
                    ],
                  ),
                ),

              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
