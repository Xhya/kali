import 'package:flutter/material.dart';
import 'package:kalori/client/Style.service.dart';
import 'package:kalori/core/services/Navigation.service.dart';
import 'package:provider/provider.dart';
import 'package:kalori/client/states/quickAddMeal.state.dart';
import 'package:kalori/client/widgets/LoaderIcon.widget.dart';
import 'package:kalori/core/actions/nutriScore.actions.dart';
import 'package:kalori/core/services/Translation.service.dart';

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

    return Container(
      height: 250,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: controller,
            onChanged: (value) {
              onInputUpdateUserMealText(value);
            },
            textCapitalization: TextCapitalization.sentences,
            minLines: 1,
            maxLines: 6,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: t('describe_your_meal', [
                quickAddMealState.chosenPeriod.value != null
                    ? t(quickAddMealState.chosenPeriod.value!.label)
                    : "repas",
              ]),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (userMealText.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        onClickAddMeal();
                      },
                      child:
                          isLoading
                              ? LoaderIcon()
                              : Text(
                                t('add'),
                                style: style.fontsize.sm.merge(
                                  style.text.color1,
                                ),
                              ),
                    ),
                  SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      onClickCloseQuickAddMode();
                    },
                    child: Icon(Icons.close),
                  ),
                  SizedBox(width: 12),
                ],
              ),
            ),
          ),
          SizedBox(height: 12),
          AnimatedContainer(
            duration: Duration(seconds: 2),
            curve: Curves.easeInOut,
            width: isExpanded ? double.maxFinite : 0,
            height: isExpanded ? 120 : 0,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: Text(
              "Voici un résumé de vos nutriments:\nProtétines: ${quickAddMealState.nutriScore.value?.proteinAmount.toInt()}g\nGlucides: ${quickAddMealState.nutriScore.value?.glucidAmount.toInt()}g\nLipides: ${quickAddMealState.nutriScore.value?.lipidAmount.toInt()}g\nCalories: ${quickAddMealState.nutriScore.value?.caloryAmount.toInt()}g",
              maxLines: 5,
            ),
          ),
        ],
      ),
    );
  }
}
