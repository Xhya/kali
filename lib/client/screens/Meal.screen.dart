import 'package:flutter/material.dart';
import 'package:kali/client/widgets/DateSelector.widget.dart';
import 'package:kali/client/widgets/MainButton.widget.dart';
import 'package:kali/client/widgets/MealComputerInput.widget.dart';
import 'package:kali/client/widgets/ShareButton.widget.dart';
import 'package:kali/client/widgets/ThinkingWidget.widget.dart';
import 'package:kali/core/domains/meal.service.dart';
import 'package:kali/core/domains/nutriscore.service.dart';
import 'package:kali/core/models/NutriScore.model.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/states/date.state.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/layout/Base.scaffold.dart';
import 'package:kali/client/widgets/CustomCard.widget.dart';
import 'package:kali/client/widgets/MealPeriodsHorizontal.widget.dart';
import 'package:kali/client/widgets/NutriScoreGauges.widget.dart';
import 'package:kali/core/states/meal.state.dart';
import 'package:kali/core/states/editMeal.state.dart';
import 'package:kali/core/models/Meal.model.dart';
import 'package:kali/core/models/MealPeriod.enum.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/core/states/Ai.state.dart';

Future<void> onUpdateMeal() async {
  try {
    editMealState.isRegisterLoading.value = true;
    final meal = mealState.currentMeal.value;
    if (meal != null) {
      await MealService().updateMeal(
        mealId: meal.id,
        period: editMealState.editingMealPeriod.value,
        userText: editMealState.editingUserTextMeal.value,
        nutriscoreId: editMealState.editingNutriScore.value?.id,
        date: editMealState.editingDate.value,
      );
      editMealState.editingNutriScore.value = null;
      navigationService.navigateBack();
    }
  } catch (e, stack) {
    errorService.notifyError(e: e, stack: stack);
  } finally {
    editMealState.isRegisterLoading.value = false;
  }
}

void onClickSelectPeriod(MealPeriodEnum? period) {
  editMealState.editingMealPeriod.value = period;
}

Future<void> onComputeEditingMeal() async {
  try {
    aiState.aiNotUnderstandError.value = false;
    editMealState.editingNutriScore.value = null;
    if (!editMealState.isComputeLoading.value &&
        editMealState.editingUserTextMeal.value.isNotEmpty == true) {
      editMealState.isComputeLoading.value = true;
      final nutriscore = await nutriscoreService.computeNutriScore(
        userText: editMealState.editingUserTextMeal.value,
      );
      editMealState.editingNutriScore.value = nutriscore;
    }
  } finally {
    editMealState.isComputeLoading.value = false;
  }
}

class MealScreen extends StatefulWidget {
  const MealScreen({super.key});

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  MealModel? meal;

  @override
  void initState() {
    editMealState.isComputeLoading.value = false;
    editMealState.isRegisterLoading.value = false;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        meal = mealState.currentMeal.value;
      });
      editMealState.editingUserTextMeal.value =
          meal?.nutriscore?.userText ?? "";
      editMealState.editingMealPeriod.value = meal?.period;
      editMealState.editingDate.value = meal?.date;
    });
    super.initState();
    dateState.currentDate.addListener(() {
      editMealState.editingDate.value = dateState.currentDate.value;
    });
  }

  @override
  void dispose() {
    dateState.currentDate.removeListener(() {
      editMealState.editingDate.value = null;
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MealPeriodEnum? mealPeriod = context.select(
      (EditMealState s) => s.editingMealPeriod.value,
    );
    bool canSave = context.select((EditMealState s) => s.canSave);
    bool canCompute = context.select((EditMealState s) => s.canCompute);
    bool isComputeLoading = context.select(
      (EditMealState s) => s.isComputeLoading.value,
    );
    bool isRegisterLoading = context.select(
      (EditMealState s) => s.isRegisterLoading.value,
    );
    String editingUserTextMeal = context.select(
      (EditMealState s) => s.editingUserTextMeal.value,
    );
    NutriScore? editingNutriScore = context.select(
      (EditMealState s) => s.editingNutriScore.value,
    );
    DateTime? editingDate = context.select(
      (EditMealState s) => s.editingDate.value,
    );

    if (meal == null) {
      return SizedBox.shrink();
    }

    return BaseScaffold(
      backButton: true,
      onNavigateBack: () {
        editMealState.editingNutriScore.value = null;
      },
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: style.background.greenTransparent.color,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12),
                    if (editingDate != null)
                      DateSelector(
                        currentDate: editingDate,
                        canNavigate: false,
                      ),
                    SizedBox(height: 32),
                    MealPeriodsHorizontalWidget(
                      withAll: false,
                      onClickSelectPeriod: (period) {
                        onClickSelectPeriod(period);
                      },
                      chosenPeriods: mealPeriod != null ? [mealPeriod] : [],
                    ),
                    SizedBox(height: 24),
                    MealComputerInput(
                      mealText: editingUserTextMeal,
                      onUpdate: (value) {
                        editMealState.editingNutriScore.value = null;
                        editMealState.editingUserTextMeal.value = value;
                      },
                      onCompute: () {
                        onComputeEditingMeal();
                      },
                      isLoading: isComputeLoading,
                      disabled: !canCompute,
                      maxLines: 100,
                    ),
                    SizedBox(height: 16),
                    CustomCard(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        spacing: 12,
                        children: [
                          Text(
                            "⚖️",
                            textAlign: TextAlign.start,
                            style: style.text.green
                                .merge(style.fontsize.md)
                                .merge(style.fontweight.bold),
                          ),

                          if (meal?.nutriscore?.caloryAmount != null)
                            Text(
                              "${meal!.nutriscore!.caloryAmount.toString()} calories",
                              textAlign: TextAlign.start,
                              style: style.text.neutral
                                  .merge(style.fontsize.sm)
                                  .merge(style.fontweight.bold)
                                  .merge(
                                    TextStyle(
                                      decoration:
                                          editingNutriScore == null
                                              ? TextDecoration.none
                                              : TextDecoration.lineThrough,
                                    ),
                                  ),
                            ),
                          if (editingNutriScore != null)
                            Text(
                              "${editingNutriScore.caloryAmount.toString()} calories",
                              textAlign: TextAlign.start,
                              style: style.text.neutral
                                  .merge(style.fontsize.sm)
                                  .merge(style.fontweight.bold)
                                  .merge(
                                    TextStyle(decoration: TextDecoration.none),
                                  ),
                            ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16),

                    NutriScoreGaugesWidget(
                      mealsByPeriods: [meal!],
                      withTotal: false,
                    ),

                    SizedBox(height: 16),

                    if (mealState.currentMeal.value?.nutriscore?.thinking !=
                        null)
                      ThinkingWidget(
                        thinking:
                            editingNutriScore == null ||
                                    editingNutriScore.thinking == null
                                ? mealState
                                    .currentMeal
                                    .value!
                                    .nutriscore!
                                    .thinking!
                                : editingNutriScore.thinking!,
                      ),
                  ],
                ),
              ),
              if (meal?.nutriscore?.id != null)
                Positioned(
                  top: 0,
                  right: 0,
                  child: ShareButtonWidget(
                    message:
                        "Voici le repas que l'on a probablement partagé ! Ajoute-le toi aussi 😉 https://horace-organization.com/home/quick-add?id=${meal!.nutriscore!.id}",
                  ),
                ),
            ],
          ),
        ),
        floatingActionButton: MainButtonWidget(
          onClick: () {
            navigationService.context = context;
            onUpdateMeal();
          },
          text: "Enregistrer",
          isLoading: isRegisterLoading,
          disabled: !canSave,
        ),
      ),
    );
  }
}
