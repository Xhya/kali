import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/client/states/quickAddMeal.state.dart';

onClickCloseQuickAddMode() {
  navigationService.closeBottomSheet();
  quickAddMealState.chosenPeriod.value = null;
  quickAddMealState.userMealText.value = "";
}

class QuickAddMealHeaderWidget extends StatefulWidget {
  const QuickAddMealHeaderWidget({super.key});

  @override
  State<QuickAddMealHeaderWidget> createState() =>
      _QuickAddMealHeaderWidgetState();
}

class _QuickAddMealHeaderWidgetState extends State<QuickAddMealHeaderWidget> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
