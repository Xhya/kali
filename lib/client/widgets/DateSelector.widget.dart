import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/core/states/meal.state.dart';
import 'package:kali/core/services/Datetime.extension.dart';

void onClickLeftArrow() {
  mealState.currentDate.value = mealState.currentDate.value.subtract(
    Duration(days: 1),
  );
}

void onClickRightArrow() {
  mealState.currentDate.value = mealState.currentDate.value.add(
    Duration(days: 1),
  );
}

String getFormattedDate(DateTime date) {
  if (date.isSameDay(DateTime.now())) {
    return "aujourd'hui";
  }

  return date.formateDate("EE dd MMMM");
}

class DateSelector extends StatelessWidget {
  const DateSelector({
    super.key,
    required this.currentDate,
    this.canNavigate = true,
  });

  final DateTime currentDate;
  final bool canNavigate;

  @override
  Widget build(BuildContext context) {
    Future<void> openDatePicker() async {
      var newDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now().add(Duration(days: 31)),
        locale: const Locale('fr', 'FR'),
      );

      if (newDate != null) {
        mealState.currentDate.value = newDate;
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 12,
      children: [
        if (canNavigate)
          IconButton(
            padding: EdgeInsets.all(0),
            onPressed: () {
              HapticFeedback.vibrate();
              onClickLeftArrow();
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                style.iconBackground.color1.color,
              ),
            ),
            icon: Icon(Icons.chevron_left_outlined),
            color: style.icon.color1.color,
            iconSize: style.fontsize.xl2.fontSize,
          ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              openDatePicker();
            },
            child: Text(
              getFormattedDate(currentDate),
              style: style.text.neutral.merge(style.fontsize.md),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        if (canNavigate)
          IconButton.filled(
            padding: EdgeInsets.all(0),
            onPressed: () {
              onClickRightArrow();
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                style.iconBackground.color1.color,
              ),
            ),
            icon: Icon(Icons.chevron_right_outlined),
            color: style.icon.color1.color,
            iconSize: style.fontsize.xl2.fontSize,
          ),
      ],
    );
  }
}
