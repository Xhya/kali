import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/CustomButton.widget.dart';
import 'package:kali/client/widgets/Expanded.widget.dart';
import 'package:kali/client/widgets/MealPeriodsWrap.widget.dart';
import 'package:kali/client/widgets/NutriScore2by2.widget.dart';
import 'package:kali/client/widgets/QuickAddMealHeader.widget.dart';
import 'package:kali/core/models/MealPeriod.enum.dart';
import 'package:kali/core/models/NutriScore.model.dart';
import 'package:kali/core/services/AI.service.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/utils/computeDayAverages.utils.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/states/quickAddMeal.state.dart';
import 'package:kali/core/actions/nutriScore.actions.dart';

onClickSelectPeriod(MealPeriodEnum period) {
  quickAddMealState.chosenPeriod.value = period;
}

onInputUpdateUserMealText(String value) {
  quickAddMealState.userMealText.value = value;
}

onClickQuickSuffixIcon() async {
  await computeNutriScoreAction();
}

onClickAddMealToDay() async {
  await addMealAction();
  computeDayAverages();
  quickAddMealState.userMealText.value = "";
  navigationService.closeBottomSheet();
}

class QuickAddMealWidget extends StatefulWidget {
  const QuickAddMealWidget({super.key});

  @override
  State<QuickAddMealWidget> createState() => _QuickAddMealWidgetState();
}

class _QuickAddMealWidgetState extends State<QuickAddMealWidget> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    quickAddMealState.nutriScore.addListener(() {
      final nutri = quickAddMealState.nutriScore.value;
      if (nutri != null && !quickAddMealState.isExpanded.value) {
        quickAddMealState.isExpanded.value = true;
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget? suffixIcon = context.watch<QuickAddMealState>().suffixIcon;
    MealPeriodEnum? chosenPeriod =
        context.watch<QuickAddMealState>().chosenPeriod.value;
    NutriScore? nutriScore =
        context.watch<QuickAddMealState>().nutriScore.value;

    return Container(
      color: style.background.greenTransparent.color,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              child: Container(
                alignment: Alignment.center,
                child: TextField(
                  controller: controller,
                  onChanged: (value) {
                    onInputUpdateUserMealText(value);
                  },
                  textCapitalization: TextCapitalization.sentences,
                  minLines: 1,
                  maxLines: 6,
                  style: style.text.neutral,
                  decoration: InputDecoration(
                    errorText:
                        aiService.aiNotUnderstandError.value
                            ? 'Veuillez être plus précis'
                            : null,
                    filled: true,
                    fillColor: style.background.neutral.color,
                    border: InputBorder.none,
                    hintText: "Quel est le menu du jour ?",
                    hintStyle: style.text.neutral,
                    suffixIcon: suffixIcon,
                  ),
                ),
              ),
            ),
            if (nutriScore != null)
              ExpandedWidget(
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    NutriScore2by2Widget(nutriScore: nutriScore),
                    SizedBox(height: 16),
                    ButtonWidget(
                      text: "Ajouter à la journée",
                      buttonType: ButtonTypeEnum.filled,
                      onPressed: () {
                        onClickAddMealToDay();
                      },
                      fullWidth: false,
                      disabled: false,
                      isLoading: false,
                    ),
                  ],
                ),
              ),
            SizedBox(height: 52),
          ],
        ),
      ),
    );
  }
}
