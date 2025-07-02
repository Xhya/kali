import 'package:flutter/material.dart';
import 'package:kalori/client/layout/Title.scaffold.dart';
import 'package:kalori/client/states/quickAddMeal.state.dart';
import 'package:kalori/client/widgets/CustomInput.dart';
import 'package:kalori/client/widgets/LoaderIcon.widget.dart';
import 'package:kalori/client/widgets/MealPeriodsHorizontal.widget.dart';
import 'package:kalori/client/widgets/NutriScoreGauges.widget.dart';
import 'package:kalori/core/domains/meal.state.dart';
import 'package:kalori/client/states/editMeal.state.dart';
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

onClickSelectPeriod(MealPeriodEnum period) {
  editMealState.editingMealPeriod.value = period;
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
          color: style.background.color1.color,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              MealPeriodsHorizontalWidget(
                onClickSelectPeriod: (period) {
                  onClickSelectPeriod(period);
                },
                chosenPeriod: editingMealPeriod,
              ),
              SizedBox(height: 16),
              CustomInput(
                onChanged: (value) {
                  editMealState.editingUserTextMeal.value = value;
                },
                placeholder: t('describe_your_meal', ["repas"]),
                suffixText: "g",
                suffixIcon: IconButton(
                  icon:
                      isLoading
                          ? LoaderIcon()
                          : Icon(Icons.save, color: style.icon.color1.color),
                  onPressed: () {
                    onUpdateMeal();
                  },
                ),
              ),
              SizedBox(height: 16),
              NutriScoreGaugesWidget(meals: [meal!]),
            ],
          ),
        ),
      ),
    );
  }
}
