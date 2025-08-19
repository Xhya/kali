import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/Utils/MaxCharactersCountFormatter.utils.dart';
import 'package:kali/client/widgets/CustomIcon.widget.dart';
import 'package:kali/client/widgets/CustomInput.dart';
import 'package:kali/client/widgets/Expanded.widget.dart';
import 'package:kali/client/widgets/LoaderIcon.widget.dart';
import 'package:kali/client/widgets/MainButton.widget.dart';
import 'package:kali/client/widgets/MealPeriodsWrap.widget.dart';
import 'package:kali/client/widgets/NutriScore2by2.widget.dart';
import 'package:kali/client/widgets/QuickAddMealHeader.widget.dart';
import 'package:kali/core/models/MealPeriod.enum.dart';
import 'package:kali/core/models/NutriScore.model.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/states/Ai.state.dart';
import 'package:kali/core/states/Texts.state.dart';
import 'package:provider/provider.dart';
import 'package:kali/core/states/quickAddMeal.state.dart';
import 'package:kali/core/actions/nutriScore.actions.dart';

onClickSelectPeriod(MealPeriodEnum period) {
  quickAddMealState.chosenPeriod.value = period;
}

onInputUpdateUserMealText(String value) {
  quickAddMealState.meal.value?.removeNutriScore();
  quickAddMealState.userMealText.value = value;
}

onClickSuffixIcon() async {
  aiState.aiNotUnderstandError.value = false;
  if (!quickAddMealState.isLoading.value &&
      quickAddMealState.userMealText.value.isNotEmpty &&
      quickAddMealState.chosenPeriod.value != null) {
    await computeNutriScoreAction();
  }
}

onClickAddMealToDay() async {
  try {
    await addMealAction();
    quickAddMealState.userMealText.value = "";
    navigationService.closeBottomSheet();
  } catch (e, stack) {
    errorService.notifyError(e: e, stack: stack);
  }
}

class QuickAddMealWidget extends StatefulWidget {
  const QuickAddMealWidget({super.key});

  @override
  State<QuickAddMealWidget> createState() => _QuickAddMealWidgetState();
}

class _QuickAddMealWidgetState extends State<QuickAddMealWidget> {
  @override
  void initState() {
    super.initState();

    quickAddMealState.meal.addListener(() {
      final nutri = quickAddMealState.meal.value?.nutriscore;
      if (nutri != null && !quickAddMealState.isExpanded.value) {
        quickAddMealState.isExpanded.value = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    MealPeriodEnum? chosenPeriod = context.select(
      (QuickAddMealState s) => s.chosenPeriod.value,
    );
    bool isLoading = context.select((QuickAddMealState s) => s.isLoading.value);
    String userMealText = context.select(
      (QuickAddMealState s) => s.userMealText.value,
    );
    bool aiNotUnderstandError = context.select(
      (AIState s) => s.aiNotUnderstandError.value,
    );
    NutriScore? nutriScore =
        context.watch<QuickAddMealState>().meal.value?.nutriscore;
    bool computed = context.watch<QuickAddMealState>().computed.value;

    return SingleChildScrollView(
      child: Container(
        color: style.background.greenTransparent.color,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
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

              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      child: Container(
                        alignment: Alignment.center,
                        child: CustomInput(
                          content: userMealText,
                          onChanged: (value) {
                            onInputUpdateUserMealText(value);
                          },
                          placeholder: "Quel est le menu du jour ?",
                          inputFormatters: [
                            MaxCharactersCountFormatter(
                              maxLength: textsState.maxCharacterCount.value,
                            ),
                          ],
                          minLines: 1,
                          maxLines: 2,
                          textCapitalization: TextCapitalization.sentences,
                          errorText:
                              aiNotUnderstandError
                                  ? 'Veuillez être plus précis'
                                  : null,
                          maxLength: textsState.maxCharacterCount.value,
                        ),
                      ),
                    ),
                  ),

                  CustomIconWidget(
                    icon:
                        isLoading
                            ? LoaderIcon()
                            : Icon(
                              Icons.calculate_outlined,
                              color: style.icon.color1.color,
                              size: 22,
                            ),
                    onClick: () {
                      onClickSuffixIcon();
                    },
                    disabled: userMealText.isEmpty || chosenPeriod == null,
                  ),
                ],
              ),

              if (computed)
                ExpandedWidget(
                  child: Column(
                    children: [
                      SizedBox(height: 16),
                      Expanded(
                        child: NutriScore2by2Widget(nutriScore: nutriScore),
                      ),
                      SizedBox(height: 16),
                      MainButtonWidget(
                        onClick: () {
                          onClickAddMealToDay();
                        },
                        iconWidget: Icon(Icons.add),
                        text: "Ajouter à la journée",
                        disabled: nutriScore == null,
                      ),
                    ],
                  ),
                ),

              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
