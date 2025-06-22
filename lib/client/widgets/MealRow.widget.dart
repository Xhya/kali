import 'package:flutter/material.dart';
import 'package:kalori/client/widgets/MealPeriodTag.widget.dart';
import 'package:kalori/core/models/Meal.model.dart';

class MealRowWidget extends StatefulWidget {
  const MealRowWidget({super.key, required this.meal});

  final MealModel meal;

  @override
  State<MealRowWidget> createState() => _MealPeriodTagWidgetState();
}

class _MealPeriodTagWidgetState extends State<MealRowWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            spacing: 4,
            children: [
              MealPeriodTagWidget(mealPeriod: widget.meal.period),
              Expanded(
                child: Text(
                  widget.meal.mealDescription,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
        if (widget.meal.nutriScore != null)
          Text("${widget.meal.nutriScore!.caloryAmount.toString()} kcal"),
      ],
    );
  }
}
