import 'package:flutter/material.dart';
import 'package:kalori/client/widgets/MealPeriodTag.widget.dart';
import 'package:kalori/core/models/NutriScore.model.dart';

class MealRowWidget extends StatefulWidget {
  const MealRowWidget({super.key, required this.nutriScore});

  final NutriScore nutriScore;

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
              MealPeriodTagWidget(mealPeriod: widget.nutriScore.period),
              Expanded(
                child: Text(
                  widget.nutriScore.mealDescription,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
        Text("${widget.nutriScore.caloryAmount.toString()} kcal"),
      ],
    );
  }
}
