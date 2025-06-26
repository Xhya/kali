import 'package:flutter/material.dart';
import 'package:kalori/client/Style.service.dart';
import 'package:kalori/client/widgets/MealPeriodsHorizontal.widget.dart';
import 'package:kalori/core/models/MealPeriod.enum.dart';
import 'package:kalori/core/services/Navigation.service.dart';
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
  if (quickAddMealState.nutriScore.value != null) {
    await addMealAction();
    return;
  }

  if (quickAddMealState.canSend) {
    await computeNutriScoreAction();
  } else {
    onClickCloseQuickAddMode();
  }
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
              // TextField(
              //   controller: controller,
              //   onChanged: (value) {
              //     onInputUpdateUserMealText(value);
              //   },
              //   textCapitalization: TextCapitalization.sentences,
              //   minLines: 1,
              //   maxLines: 6,
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(),
              //     labelText: t('describe_your_meal', [
              //       quickAddMealState.chosenPeriod.value != null
              //           ? t(quickAddMealState.chosenPeriod.value!.label)
              //           : "repas",
              //     ]),
              //     suffixIcon: Row(
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         if (userMealText.isNotEmpty)
              //           GestureDetector(
              //             onTap: () {
              //               onClickAddMeal();
              //             },
              //             child:
              //                 isLoading
              //                     ? LoaderIcon()
              //                     : Text(
              //                       t('add'),
              //                       style: style.fontsize.sm.merge(
              //                         style.text.neutral,
              //                       ),
              //                     ),
              //           ),
              //         SizedBox(width: 12),
              //         GestureDetector(
              //           onTap: () {
              //             onClickCloseQuickAddMode();
              //           },
              //           child: Icon(Icons.close),
              //         ),
              //         SizedBox(width: 12),
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(height: 12),
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
                  height: isExpanded ? 40 : 0,
                  padding: EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: style.border.color.color1.color!),
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Text(
                    "PR: ${quickAddMealState.nutriScore.value?.proteinAmount.toInt()}g / GL: ${quickAddMealState.nutriScore.value?.glucidAmount.toInt()}g / LI: ${quickAddMealState.nutriScore.value?.lipidAmount.toInt()}g / CAL: ${quickAddMealState.nutriScore.value?.caloryAmount.toInt()}kcal",
                    maxLines: 1,
                    style: style.text.color1,
                  ),
                ),
              ),
              SizedBox(height: 16),

              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
