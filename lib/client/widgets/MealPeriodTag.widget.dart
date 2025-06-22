import 'package:flutter/material.dart';
import 'package:kalori/client/Style.service.dart';
import 'package:kalori/core/models/MealPeriod.enum.dart';
import 'package:kalori/core/services/Translation.service.dart';

class MealPeriodTagWidget extends StatefulWidget {
  const MealPeriodTagWidget({super.key, required this.mealPeriod});

  final MealPeriodEnum mealPeriod;

  @override
  State<MealPeriodTagWidget> createState() => _MealPeriodTagWidgetState();
}

class _MealPeriodTagWidgetState extends State<MealPeriodTagWidget> {
  @override
  Widget build(BuildContext context) {
    final color =
        widget.mealPeriod == MealPeriodEnum.breakfast
            ? Colors.amber
            : widget.mealPeriod == MealPeriodEnum.lunch
            ? Colors.red
            : widget.mealPeriod == MealPeriodEnum.snack
            ? Colors.green
            : Colors.blue;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        color: color,
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Text(t(widget.mealPeriod.label), style: style.text.color3),
      ),
    );
  }
}
