import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/core/domains/meal.state.dart';
import 'package:kali/core/services/Datetime.extension.dart';

onClickLeftArrow() {
  mealState.currentDate.value = mealState.currentDate.value.subtract(
    Duration(days: 1),
  );
}

onClickRightArrow() {
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
  const DateSelector({super.key, required this.currentDate});

  final DateTime currentDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 12,
      children: [
        IconButton(
          onPressed: () {
            onClickLeftArrow();
          },
          icon: Icon(Icons.chevron_left_outlined),
          color: style.icon.color3.color,
          iconSize: style.fontsize.xl.fontSize,
        ),
        Expanded(
          child: Text(
            getFormattedDate(currentDate),
            style: style.text.reverse_neutral
                .merge(style.fontsize.sm)
                .merge(style.fontweight.bold),
          ),
        ),
        IconButton.filled(
          onPressed: () {
            onClickRightArrow();
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              style.background.color5.color,
            ),
          ),
          icon: Icon(Icons.chevron_right_outlined),
          color: style.icon.color3.color,
          iconSize: style.fontsize.xl.fontSize,
        ),
      ],
    );
  }
}
