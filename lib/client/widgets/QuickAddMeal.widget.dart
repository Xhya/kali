import 'package:flutter/material.dart';
import 'package:kalori/client/Style.service.dart';
import 'package:kalori/client/widgets/MealPeriodsHorizontal.widget.dart';
import 'package:kalori/core/models/MealPeriod.enum.dart';
import 'package:kalori/core/services/Navigation.service.dart';
import 'package:provider/provider.dart';
import 'package:kalori/client/states/quickAddMeal.state.dart';
import 'package:kalori/client/widgets/LoaderIcon.widget.dart';
import 'package:kalori/core/actions/nutriScore.actions.dart';

onClickSelectPeriod(MealPeriodEnum period) {
  quickAddMealState.chosenPeriod.value = period;
}

onClickCloseQuickAddMode() {
  navigationService.closeBottomSheet();
  quickAddMealState.userMealText.value = "";
}

onInputUpdateUserMealText(String value) {
  quickAddMealState.userMealText.value = value;
}

onClickAddMeal() {
  addMealAction();
}

class QuickAddMealWidget extends StatefulWidget {
  const QuickAddMealWidget({super.key});

  @override
  State<QuickAddMealWidget> createState() => _QuickAddMealWidgetState();
}

class _QuickAddMealWidgetState extends State<QuickAddMealWidget> {
  TextEditingController controller = TextEditingController();
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();

    quickAddMealState.nutriScore.addListener(() {
      final nutri = quickAddMealState.nutriScore.value;
      if (nutri != null && !isExpanded) {
        setState(() {
          isExpanded = true;
        });
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
    String userMealText = context.watch<QuickAddMealState>().userMealText.value;
    bool isLoading = context.watch<QuickAddMealState>().isLoading.value;
    MealPeriodEnum? chosenPeriod =
        context.watch<QuickAddMealState>().chosenPeriod.value;

    return Container(
      color: style.background.color4.color,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        child: Container(
          color: style.background.color4.color,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 12),
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
              // AnimatedContainer(
              //   duration: Duration(seconds: 2),
              //   curve: Curves.easeInOut,
              //   width: isExpanded ? double.maxFinite : 0,
              //   height: isExpanded ? 120 : 0,
              //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              //   decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              //   child: Text(
              //     "Voici un résumé de vos nutriments:\nProtétines: ${quickAddMealState.nutriScore.value?.proteinAmount.toInt()}g\nGlucides: ${quickAddMealState.nutriScore.value?.glucidAmount.toInt()}g\nLipides: ${quickAddMealState.nutriScore.value?.lipidAmount.toInt()}g\nCalories: ${quickAddMealState.nutriScore.value?.caloryAmount.toInt()}g",
              //     maxLines: 5,
              //   ),
              // ),
              MealPeriodsHorizontalWidget(
                onClickSelectPeriod: (MealPeriodEnum period) {
                  onClickSelectPeriod(period);
                },
                chosenPeriod: chosenPeriod,
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  color: style.background.color4.color,
                  height: 80,
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
                      border: InputBorder.none,
                      hintText: "J'ai mangé un acaï bowl",
                      hintStyle: style.text.color1,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          if (!isLoading) {
                            if (userMealText.isNotEmpty) {
                              onClickAddMeal();
                            } else {
                              onClickCloseQuickAddMode();
                            }
                          }
                        },
                        child:
                            isLoading
                                ? LoaderIcon()
                                : userMealText.isNotEmpty
                                ? Icon(
                                  Icons.send,
                                  color: style.icon.color1.color,
                                )
                                : Icon(
                                  Icons.close,
                                  color: style.icon.color1.color,
                                ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
