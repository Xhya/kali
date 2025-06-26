import 'package:flutter/material.dart';
import 'package:kalori/client/Style.service.dart';
import 'package:kalori/client/widgets/MealPeriodTag.widget.dart';
import 'package:kalori/core/models/Meal.model.dart';

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
            spacing: 4,
            children: [
              MealPeriodTagWidget(
                mealPeriod: widget.meal.period,
                onLightBackground: widget.onLightBackground,
              ),
              Expanded(
                child: Text(
                  widget.meal.mealDescription,
                  style: style.fontsize.md.merge(textColor),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
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
