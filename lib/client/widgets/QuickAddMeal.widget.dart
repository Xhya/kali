import 'package:flutter/material.dart';
import 'package:kalori/client/Style.service.dart';
import 'package:kalori/client/widgets/CustomButton.widget.dart';
import 'package:kalori/client/widgets/CustomCard.widget.dart';
import 'package:kalori/client/widgets/MealPeriodsHorizontal.widget.dart';
import 'package:kalori/core/models/MealPeriod.enum.dart';
import 'package:kalori/core/models/NutriScore.model.dart';
import 'package:kalori/core/services/Navigation.service.dart';
import 'package:kalori/core/utils/macroIcon.utils.dart';
import 'package:provider/provider.dart';
import 'package:kalori/client/states/quickAddMeal.state.dart';
import 'package:kalori/core/actions/nutriScore.actions.dart';

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
  if (quickAddMealState.canSend) {
    await computeNutriScoreAction();
  } else {
    onClickCloseQuickAddMode();
  }
}

onClickAddMealToDay() async {
  addMealAction();
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
    bool isExpanded = context.watch<QuickAddMealState>().isExpanded.value;
    NutriScore? nutriScore =
        context.watch<QuickAddMealState>().nutriScore.value;

    return Container(
      color: style.background.color4.color,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        child: Container(
          color: style.background.color4.color,
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
                      style: style.text.reverse_neutral.merge(
                        style.fontsize.lg,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        onClickCloseQuickAddMode();
                      },
                      icon: Icon(
                        Icons.close,
                        color: style.icon.color2.color,
                        size: style.fontsize.lg.fontSize,
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
                      filled: true,
                      fillColor: style.background.color3.color,
                      border: InputBorder.none,
                      hintText: "Quel est le menu du jour ?",
                      hintStyle: style.text.color1,
                      suffixIcon:
                          suffixIcon != null
                              ? GestureDetector(
                                onTap: () {
                                  onClickQuickSuffixIcon();
                                },
                                child: suffixIcon,
                              )
                              : null,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  alignment: Alignment.center,
                  width: isExpanded ? double.maxFinite : 0,
                  height: isExpanded ? 220 : 0,
                  padding: EdgeInsets.symmetric(vertical: 4),
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: style.border.color.color1.color!),
                  //   borderRadius: const BorderRadius.all(Radius.circular(16)),
                  // ),
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      CustomCard(
                        child: SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 2 - 12 * 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "$caloryIcon calories",
                                style: style.text.reverse_neutral.merge(
                                  style.fontsize.sm,
                                ),
                              ),
                              Text(
                                nutriScore == null
                                    ? "-"
                                    : nutriScore.caloryAmount.toString(),
                                style: style.text.reverse_neutral.merge(
                                  style.fontsize.sm,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      CustomCard(
                        child: SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 2 - 12 * 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "$glucidIcon glucides",
                                style: style.text.reverse_neutral.merge(
                                  style.fontsize.sm,
                                ),
                              ),
                              Text(
                                nutriScore == null
                                    ? "-"
                                    : nutriScore.glucidAmount.toString(),
                                style: style.text.reverse_neutral.merge(
                                  style.fontsize.sm,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      CustomCard(
                        child: SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 2 - 12 * 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "$proteinIcon protéines",
                                style: style.text.reverse_neutral.merge(
                                  style.fontsize.sm,
                                ),
                              ),
                              Text(
                                nutriScore == null
                                    ? "-"
                                    : nutriScore.proteinAmount.toString(),
                                style: style.text.reverse_neutral.merge(
                                  style.fontsize.sm,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      CustomCard(
                        child: SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 2 - 12 * 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "$lipidIcon lipides",
                                style: style.text.reverse_neutral.merge(
                                  style.fontsize.sm,
                                ),
                              ),
                              Text(
                                nutriScore == null
                                    ? "-"
                                    : nutriScore.lipidAmount.toString(),
                                style: style.text.reverse_neutral.merge(
                                  style.fontsize.sm,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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

                  // Text(
                  //   "PR: ${quickAddMealState.nutriScore.value?.proteinAmount.toInt()}g / GL: ${quickAddMealState.nutriScore.value?.glucidAmount.toInt()}g / LI: ${quickAddMealState.nutriScore.value?.lipidAmount.toInt()}g / CAL: ${quickAddMealState.nutriScore.value?.caloryAmount.toInt()}kcal",
                  //   maxLines: 1,
                  //   style: style.text.color1,
                  // ),
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
