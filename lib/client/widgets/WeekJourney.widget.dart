import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/CustomCard.widget.dart';
import 'package:kali/core/models/Meal.model.dart';
import 'package:kali/core/models/NutriScore.model.dart';
import 'package:kali/core/services/Datetime.extension.dart';
import 'package:kali/core/states/date.state.dart';
import 'package:kali/core/states/meal.state.dart';
import 'package:kali/core/states/user.state.dart';
import 'package:kali/core/utils/computeDayAverages.utils.dart';
import 'package:provider/provider.dart';

class WeekJourneyWidget extends StatefulWidget {
  const WeekJourneyWidget({super.key});

  @override
  State<WeekJourneyWidget> createState() => _WeekJourneyWidgetState();
}

class _WeekJourneyWidgetState extends State<WeekJourneyWidget> {
  @override
  Widget build(BuildContext context) {
    DateTime currentDate = context.select((DateState s) => s.currentDate.value);
    List<MealModel> allMeals = context.select(
      (MealState s) => s.allMeals.value,
    );

    DateTime getMonday(DateTime date) {
      // Dart, monday = 1, sunday = 7
      final int daysToSubtract = date.weekday - DateTime.monday;
      return date.subtract(Duration(days: daysToSubtract));
    }

    DateTime monday = getMonday(currentDate);

    return CustomCard(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(7, (index) {
          final date = monday.add(Duration(days: index));
          bool isCurrentDate = date.isSameDay(currentDate);
          // var challengeItem = widget.period.challengeItems[index];
          return GestureDetector(
            onTap: () {
              dateState.currentDate.value = date;
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color:
                      isCurrentDate
                          ? style.border.color.color2.color!.withOpacity(0.5)
                          : Colors.transparent,
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Text(date.formateDate('E')[0].toUpperCase()),
                  getJourneyIcon(allMeals, date),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

Widget getJourneyIcon(List<MealModel> allMeals, DateTime date) {
  final mealsOfDate =
      allMeals
          .where((it) => it.date != null ? it.date!.isSameDay(date) : false)
          .toList();

  NutriScore? personalNutriscore = userState.user.value?.nutriscore;

  final totalCalories = computeDayAverages(mealsOfDate).caloryAmount;

  return date.isToday
      ? Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: style.background.greenLight.color,
          borderRadius: BorderRadius.circular(100),
        ),
      )
      : date.isAfter(DateTime.now())
      ? Container(
        alignment: Alignment.center,
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: style.background.grey.color,
          borderRadius: BorderRadius.circular(100),
        ),
      )
      : totalCalories == 0
      ? Container(
        alignment: Alignment.center,
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: style.background.grey.color,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text("N/A", style: style.fontsize.xxxs),
      )
      : totalCalories > personalNutriscore!.caloryAmount
      ? Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: style.background.error.color,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Icon(Icons.close, size: 20, color: Colors.white),
      )
      : Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: style.background.green.color,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Icon(Icons.check, size: 20, color: Colors.white),
      );
}
