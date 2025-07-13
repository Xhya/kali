import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/core/models/MealPeriod.enum.dart';
import 'package:kali/core/services/Translation.service.dart';

class MealPeriodTagWidget extends StatefulWidget {
  const MealPeriodTagWidget({
    super.key,
    required this.mealPeriod,
    this.disabled = false,
  });

  final MealPeriodEnum mealPeriod;
  final bool disabled;

  @override
  State<MealPeriodTagWidget> createState() => _MealPeriodTagWidgetState();
}

class _MealPeriodTagWidgetState extends State<MealPeriodTagWidget> {
  @override
  Widget build(BuildContext context) {
    final icon =
        widget.mealPeriod == MealPeriodEnum.breakfast
            ? "🥯"
            : widget.mealPeriod == MealPeriodEnum.lunch
            ? "🍎"
            : widget.mealPeriod == MealPeriodEnum.snack
            ? "🍱"
            : "🍪";

    final double opacity = widget.disabled ? 0.3 : 1;

    final textColor = style.text.reverse_neutral;

    final borderColor =
        widget.mealPeriod == MealPeriodEnum.breakfast
            ? style.period.breakfastColor
            : widget.mealPeriod == MealPeriodEnum.lunch
            ? style.period.lunchColor
            : widget.mealPeriod == MealPeriodEnum.snack
            ? style.period.snackColor
            : style.period.dinerColor;

    final backgroundColor =
        widget.mealPeriod == MealPeriodEnum.breakfast
            ? style.period.breakfastColor
            : widget.mealPeriod == MealPeriodEnum.lunch
            ? style.period.lunchColor
            : widget.mealPeriod == MealPeriodEnum.snack
            ? style.period.snackColor
            : style.period.dinerColor;

    return Opacity(
      opacity: opacity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor.color!),
            color: backgroundColor.color!,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          child: Row(
            children: [
              Text(icon, style: style.fontsize.xs),
              Text(
                t(widget.mealPeriod.label),
                style: textColor.merge(style.fontsize.xs),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
