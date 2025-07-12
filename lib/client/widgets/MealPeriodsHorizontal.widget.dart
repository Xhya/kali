import 'package:flutter/material.dart';
import 'package:kali/client/widgets/CustomInkwell.widget.dart';
import 'package:kali/client/widgets/MealPeriodTag.widget.dart';
import 'package:kali/core/models/MealPeriod.enum.dart';

class MealPeriodsHorizontalWidget extends StatefulWidget {
  const MealPeriodsHorizontalWidget({
    super.key,
    required this.onClickSelectPeriod,
    required this.chosenPeriod,
  });

  final Function(MealPeriodEnum) onClickSelectPeriod;
  final MealPeriodEnum? chosenPeriod;

  @override
  State<MealPeriodsHorizontalWidget> createState() =>
      _MealPeriodsHorizontalWidgetState();
}

class _MealPeriodsHorizontalWidgetState
    extends State<MealPeriodsHorizontalWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 4),
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomInkwell(
            onTap: () {
              widget.onClickSelectPeriod(MealPeriodEnum.breakfast);
            },
            child: MealPeriodTagWidget(
              mealPeriod: MealPeriodEnum.breakfast,
              disabled:
                  widget.chosenPeriod != null &&
                  widget.chosenPeriod != MealPeriodEnum.breakfast,
            ),
          ),
          CustomInkwell(
            onTap: () {
              widget.onClickSelectPeriod(MealPeriodEnum.lunch);
            },
            child: MealPeriodTagWidget(
              mealPeriod: MealPeriodEnum.lunch,
              disabled:
                  widget.chosenPeriod != null &&
                  widget.chosenPeriod != MealPeriodEnum.lunch,
            ),
          ),
          CustomInkwell(
            onTap: () {
              widget.onClickSelectPeriod(MealPeriodEnum.snack);
            },
            child: MealPeriodTagWidget(
              mealPeriod: MealPeriodEnum.snack,
              disabled:
                  widget.chosenPeriod != null &&
                  widget.chosenPeriod != MealPeriodEnum.snack,
            ),
          ),
          CustomInkwell(
            onTap: () {
              widget.onClickSelectPeriod(MealPeriodEnum.dinner);
            },
            child: MealPeriodTagWidget(
              mealPeriod: MealPeriodEnum.dinner,
              disabled:
                  widget.chosenPeriod != null &&
                  widget.chosenPeriod != MealPeriodEnum.dinner,
            ),
          ),
        ],
      ),
    );
  }
}
