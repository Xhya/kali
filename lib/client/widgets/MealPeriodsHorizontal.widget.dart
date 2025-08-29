import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kali/client/widgets/CustomInkwell.widget.dart';
import 'package:kali/client/widgets/MealPeriodTag.widget.dart';
import 'package:kali/core/models/MealPeriod.enum.dart';

class MealPeriodsHorizontalWidget extends StatefulWidget {
  const MealPeriodsHorizontalWidget({
    super.key,
    required this.onClickSelectPeriod,
    required this.chosenPeriods,
    this.withAll = true,
  });

  final Function(MealPeriodEnum?) onClickSelectPeriod;
  final List<MealPeriodEnum> chosenPeriods;
  final bool withAll;

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
          if (widget.withAll)
            CustomInkwell(
              onTap: () {
                HapticFeedback.vibrate();
                widget.onClickSelectPeriod(null);
              },
              child: MealPeriodTagWidget(
                mealPeriod: null,
                disabled: widget.chosenPeriods.isNotEmpty,
              ),
            ),
          CustomInkwell(
            onTap: () {
              HapticFeedback.vibrate();
              widget.onClickSelectPeriod(MealPeriodEnum.breakfast);
            },
            child: MealPeriodTagWidget(
              mealPeriod: MealPeriodEnum.breakfast,
              disabled:
                  !widget.chosenPeriods.contains(MealPeriodEnum.breakfast),
            ),
          ),
          CustomInkwell(
            onTap: () {
              HapticFeedback.vibrate();
              widget.onClickSelectPeriod(MealPeriodEnum.lunch);
            },
            child: MealPeriodTagWidget(
              mealPeriod: MealPeriodEnum.lunch,
              disabled: !widget.chosenPeriods.contains(MealPeriodEnum.lunch),
            ),
          ),
          CustomInkwell(
            onTap: () {
              HapticFeedback.vibrate();
              widget.onClickSelectPeriod(MealPeriodEnum.snack);
            },
            child: MealPeriodTagWidget(
              mealPeriod: MealPeriodEnum.snack,
              disabled: !widget.chosenPeriods.contains(MealPeriodEnum.snack),
            ),
          ),
          CustomInkwell(
            onTap: () {
              HapticFeedback.vibrate();
              widget.onClickSelectPeriod(MealPeriodEnum.dinner);
            },
            child: MealPeriodTagWidget(
              mealPeriod: MealPeriodEnum.dinner,
              disabled: !widget.chosenPeriods.contains(MealPeriodEnum.dinner),
            ),
          ),
        ],
      ),
    );
  }
}
