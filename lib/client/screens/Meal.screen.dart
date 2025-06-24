import 'package:flutter/material.dart';
import 'package:kalori/client/layout/Title.scaffold.dart';
import 'package:kalori/client/widgets/LoaderIcon.widget.dart';
import 'package:kalori/client/widgets/MealPeriodTag.widget.dart';
import 'package:kalori/client/widgets/NutriScoreGauges.widget.dart';
import 'package:kalori/core/domains/meal.state.dart';
import 'package:kalori/core/domains/editMeal.state.dart';
import 'package:kalori/core/models/Meal.model.dart';
import 'package:kalori/core/models/MealPeriod.enum.dart';
import 'package:kalori/core/services/AI.service.dart';
import 'package:kalori/core/services/Error.service.dart';
import 'package:kalori/core/services/Translation.service.dart';
import 'package:provider/provider.dart';
import 'package:kalori/client/Style.service.dart';

onUpdateMeal() async {
  try {
    editMealState.isLoading.value = true;
    final userText = editMealState.editingUserTextMeal.value;
    final nutriScore = await aiService.computeNutriScore(userText);
    editMealState.editingNutriScore.value = nutriScore;
  } catch (e) {
    errorService.notifyError(e);
  } finally {
    editMealState.isLoading.value = false;
  }
}

class MealScreen extends StatefulWidget {
  const MealScreen({super.key});

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  final controller = TextEditingController();
  late MealModel? meal = context.watch<MealState>().currentMeal.value;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      editMealState.editingMealPeriod.value = meal?.period;
      controller.text = meal?.mealDescription ?? "";
    });
    super.initState();
  }

  @override
  void dispose() {
    editMealState.editingNutriScore.value = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MealPeriodEnum? editingMealPeriod =
        context.watch<EditMealState>().editingMealPeriod.value;
    bool isLoading = context.watch<EditMealState>().isLoading.value;

    if (meal == null) {
      errorService.notifyError("Missing meal");
      return SizedBox.shrink();
    }

    return TitleScaffold(
      title: t("meal"),
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: style.background.neutral.color,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      editMealState.editingMealPeriod.value =
                          MealPeriodEnum.breakfast;
                    },
                    child: MealPeriodTagWidget(
                      mealPeriod: MealPeriodEnum.breakfast,
                      disabled: editingMealPeriod != MealPeriodEnum.breakfast,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      editMealState.editingMealPeriod.value =
                          MealPeriodEnum.lunch;
                    },
                    child: MealPeriodTagWidget(
                      mealPeriod: MealPeriodEnum.lunch,
                      disabled: editingMealPeriod != MealPeriodEnum.lunch,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      editMealState.editingMealPeriod.value =
                          MealPeriodEnum.snack;
                    },
                    child: MealPeriodTagWidget(
                      mealPeriod: MealPeriodEnum.snack,
                      disabled: editingMealPeriod != MealPeriodEnum.snack,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      editMealState.editingMealPeriod.value =
                          MealPeriodEnum.dinner;
                    },
                    child: MealPeriodTagWidget(
                      mealPeriod: MealPeriodEnum.dinner,
                      disabled: editingMealPeriod != MealPeriodEnum.dinner,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextField(
                controller: controller,
                maxLines: 2,
                onChanged: (String value) {
                  editMealState.editingUserTextMeal.value = value;
                },
                decoration: InputDecoration(
                  hintText: t('describe_your_meal'),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon:
                        isLoading
                            ? LoaderIcon()
                            : const Icon(Icons.save),
                    onPressed: () {
                      onUpdateMeal();
                    },
                  ),
                ),
              ),
              SizedBox(height: 16),
              NutriScoreGaugesWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
