import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:kalori/client/Style.service.dart';
import 'package:kalori/core/domains/meal.state.dart';
import 'package:kalori/core/services/Datetime.extension.dart';

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
    return "Aujourd'hui";
  }

  if (date.isSameDay(DateTime.now().subtract(Duration(days: 1)))) {
    return "Hier";
  }

  return date.formateDate("dd MMM yyyy");
}

class DateSelector extends StatelessWidget {
  const DateSelector({super.key, required this.currentDate});

  final DateTime currentDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 12,
      children: [
        IconButton(
          onPressed: () {
            onClickLeftArrow();
          },
          icon: Icon(Icons.arrow_left),
          color: style.icon.color3.color,
          iconSize: style.fontsize.xl.fontSize,
        ),
        Container(
          alignment: Alignment.center,
          width: 200,
          child: Text(
            getFormattedDate(currentDate),
            style: style.text.reverse_neutral
                .merge(style.fontsize.lg)
                .merge(style.fontweight.bold),
          ),
        ),
        IconButton(
          onPressed: () {
            onClickRightArrow();
          },
          icon: Icon(Icons.arrow_right),
          color: style.icon.color3.color,
          iconSize: style.fontsize.xl.fontSize,
        ),
      ],
    );
  }
}
