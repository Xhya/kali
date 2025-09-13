import 'package:kali/client/widgets/CloseButton.widget.dart';
import 'package:kali/core/services/Datetime.extension.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/states/quickAddMeal.state.dart';

void onClickCloseQuickAddMode() {
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
            child: GestureDetector(
              onTap: () {
                openDatePicker();
              },
              child: Text(
                date.formateDate("EEEE dd MMMM"),
                style: style.text.neutral.merge(style.fontsize.sm),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),

          CloseButtonWidget(
            onClose: () {
              HapticFeedback.vibrate();
              onClickCloseQuickAddMode();
            },
          ),
        ],
      ),
    );
  }
}
