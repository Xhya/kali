import 'package:flutter/material.dart';
import 'package:kali/client/layout/Title.scaffold.dart';
import 'package:kali/client/widgets/CustomInput.dart';
import 'package:kali/client/widgets/LoaderIcon.widget.dart';
import 'package:kali/client/widgets/MealPeriodsWrap.widget.dart';
import 'package:kali/client/widgets/NutriScoreGauges.widget.dart';
import 'package:kali/core/states/meal.state.dart';
import 'package:kali/core/states/editMeal.state.dart';
import 'package:kali/core/models/Meal.model.dart';
import 'package:kali/core/models/MealPeriod.enum.dart';
import 'package:kali/core/services/AI.service.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/Translation.service.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';

onUpdateMeal() async {
  try {
    editMealState.isLoading.value = true;
    final userText = editMealState.editingUserTextMeal.value;
    final nutriScore = await aiService.computeNutriScore(userText);
    editMealState.editingNutriScore.value = nutriScore;
  } catch (e, stack) {
    errorService.notifyError(e: e, stack: stack);
  } finally {
    editMealState.isLoading.value = false;
  }
}

onClickSelectPeriod(MealPeriodEnum? period) {
  editMealState.editingMealPeriod.value = period;
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      meal = mealState.currentMeal.value;
      editMealState.editingUserTextMeal.value = meal?.userText ?? "";
      editMealState.editingMealPeriod.value = meal?.period;
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

    if (meal == null) {
      return SizedBox.shrink();
    }

    return TitleScaffold(
      title: t("meal"),
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: style.background.greenTransparent.color,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              MealPeriodsWrapWidget(
                onClickSelectPeriod: (MealPeriodEnum period) {
                  onClickSelectPeriod(period);
                },
                chosenPeriod: editingMealPeriod,
              ),
              SizedBox(height: 16),
              CustomInput(
                content: editMealState.editingUserTextMeal.value,
                onChanged: null,
                // suffixIcon: IconButton(
                //   icon:
                //       isLoading
                //           ? LoaderIcon()
                //           : Icon(Icons.save, color: style.icon.color1.color),
                //   onPressed: () {
                //     onUpdateMeal();
                //   },
                // ),
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
