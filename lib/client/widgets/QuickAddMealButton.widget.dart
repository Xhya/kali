import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/BottomButton.widget.dart';
import 'package:kali/core/states/quickAddMeal.state.dart';
import 'package:kali/client/widgets/QuickAddMeal.widget.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/utils/computeMealPeriod.utils.dart';

onClickAddQuickMeal() {
  quickAddMealState.reset();
  quickAddMealState.chosenPeriod.value = computeMealPeriod(DateTime.now());
  navigationService.openBottomSheet(widget: QuickAddMealWidget());
}

class QuickAddMealButtonWidget extends StatefulWidget {
  const QuickAddMealButtonWidget({super.key});

  @override
  State<QuickAddMealButtonWidget> createState() => _MealPeriodTagWidgetState();
}

class _MealPeriodTagWidgetState extends State<QuickAddMealButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomButtonWidget(
      left: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("🥳", style: TextStyle(fontSize: 24)),
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: style.fontsize.xs.fontSize,
                color: style.text.neutral.color,
              ),
              children: <TextSpan>[
                TextSpan(text: "Déjà "),
                TextSpan(
                  text: "11 jours consécutifs",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Text("De suivi de repas", style: style.fontsize.xs),
        ],
      ),
      buttonText: "🍴 ajouter",
      onClick: () {
        navigationService.context = context;
        onClickAddQuickMeal();
      },
    );
  }
}
