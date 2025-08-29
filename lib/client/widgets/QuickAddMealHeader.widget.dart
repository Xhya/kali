import 'package:kali/core/services/Datetime.extension.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/states/quickAddMeal.state.dart';

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

  Future<void> openDatePicker() async {
    var newDate = await showDatePicker(
      context: context,
      initialDate: quickAddMealState.date.value,
      firstDate: DateTime(1900),
      lastDate: DateTime.now().add(Duration(days: 31)),
      locale: const Locale('fr', 'FR'),
    );

    if (newDate != null) {
      quickAddMealState.date.value = newDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = context.select((QuickAddMealState s) => s.date.value);

    return Container(
      padding: EdgeInsets.only(left: 4),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Ajouter un repas",
                  style: style.text.neutral.merge(style.fontsize.md),
                ),
                Flexible(
                  child: Text(
                    date.formateDate("EE dd MMMM"),
                    style: style.text.neutral.merge(style.fontsize.sm),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    openDatePicker();
                  },
                  child: Icon(Icons.calendar_month, size: 24),
                ),
              ],
            ),
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
                HapticFeedback.vibrate();
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
