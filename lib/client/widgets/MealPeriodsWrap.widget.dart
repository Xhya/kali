import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kali/client/widgets/CustomInkwell.widget.dart';
import 'package:kali/client/widgets/MealPeriodTag.widget.dart';
import 'package:kali/core/models/MealPeriod.enum.dart';

class MealPeriodsWrapWidget extends StatefulWidget {
  const MealPeriodsWrapWidget({
    super.key,
    required this.onClickSelectPeriod,
    required this.chosenPeriod,
  });

  final Function(MealPeriodEnum) onClickSelectPeriod;
  final MealPeriodEnum? chosenPeriod;

  @override
  State<MealPeriodsWrapWidget> createState() => _MealPeriodsWrapWidgetState();
}

class _MealPeriodsWrapWidgetState extends State<MealPeriodsWrapWidget> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        CustomInkwell(
          onTap: () {
            HapticFeedback.vibrate();
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
            HapticFeedback.vibrate();
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
            HapticFeedback.vibrate();
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
            HapticFeedback.vibrate();
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
    );
  }
}
