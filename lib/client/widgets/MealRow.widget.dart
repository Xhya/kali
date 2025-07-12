import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/MealPeriodTag.widget.dart';
import 'package:kali/core/models/Meal.model.dart';

class MealRowWidget extends StatefulWidget {
  const MealRowWidget({
    super.key,
    required this.meal,
    this.onLightBackground = false,
  });

  final MealModel meal;
  final bool onLightBackground;

  @override
  State<MealRowWidget> createState() => _MealPeriodTagWidgetState();
}

class _MealPeriodTagWidgetState extends State<MealRowWidget> {
  @override
  Widget build(BuildContext context) {
    final textColor =
        widget.onLightBackground
            ? style.text.neutral
            : style.text.reverse_neutral;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 8,
      children: [
        Expanded(
          child: Row(
            spacing: 8,
            children: [
              if (widget.meal.period != null)
                MealPeriodTagWidget(
                  mealPeriod: widget.meal.period!,
                  onLightBackground: widget.onLightBackground,
                ),
              if (widget.meal.mealDescription != null)
              Expanded(
                child: Text(
                  widget.meal.mealDescription!,
                  style: style.fontsize.sm.merge(textColor),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
        if (widget.meal.nutriScore != null)
          Text(
            "${widget.meal.nutriScore!.caloryAmount} kcal",
            style: style.fontsize.md
                .merge(style.text.reverse_neutral)
                .merge(style.fontweight.bold),
          ),
      ],
    );
  }
}
