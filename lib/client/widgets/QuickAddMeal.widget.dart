import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/CustomButton.widget.dart';
import 'package:kali/client/widgets/Expanded.widget.dart';
import 'package:kali/client/widgets/MealPeriodsHorizontal.widget.dart';
import 'package:kali/client/widgets/NutriScore2by2.widget.dart';
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

onClickCloseQuickAddMode() {
  navigationService.closeBottomSheet();
  quickAddMealState.chosenPeriod.value = null;
  quickAddMealState.userMealText.value = "";
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
      color: style.background.greenLight.color,
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
            Container(
              padding: EdgeInsets.only(left: 4),
              width: double.maxFinite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Ajouter un repas",
                    textAlign: TextAlign.start,
                    style: style.text.neutral.merge(style.fontsize.md),
                  ),

                  Container(
                    height: 32,
                    width: 32,
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      border: Border.all(color: style.icon.color1.color!, width: 1),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: IconButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        onClickCloseQuickAddMode();
                      },
                      icon: Icon(
                        Icons.close,
                        color: style.icon.color1.color,
                        size: style.fontsize.md.fontSize,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            MealPeriodsHorizontalWidget(
              onClickSelectPeriod: (MealPeriodEnum period) {
                onClickSelectPeriod(period);
              },
              chosenPeriod: chosenPeriod,
            ),
            SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              child: Container(
                color: style.background.color4.color,
                alignment: Alignment.center,
                child: TextField(
                  controller: controller,
                  onChanged: (value) {
                    onInputUpdateUserMealText(value);
                  },
                  textCapitalization: TextCapitalization.sentences,
                  minLines: 1,
                  maxLines: 6,
                  style: style.text.reverse_neutral,
                  decoration: InputDecoration(
                    errorText:
                        aiService.aiNotUnderstandError.value
                            ? 'Veuillez être plus précis'
                            : null,
                    filled: true,
                    fillColor: style.background.color3.color,
                    border: InputBorder.none,
                    hintText: "Quel est le menu du jour ?",
                    hintStyle: style.text.color1,
                    suffixIcon: suffixIcon,
                  ),
                ),
              ),
            ),
            if (nutriScore != null) SizedBox(height: 24),
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
