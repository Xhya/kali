import 'package:flutter/material.dart';
import 'package:kalori/client/Style.service.dart';
import 'package:kalori/core/models/MealPeriod.enum.dart';
import 'package:kalori/core/services/Translation.service.dart';

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

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(color: style.border.color.color1.color!),
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: Row(
          children: [
            Text(icon, style: style.fontsize.xs),
            Text(
              t(widget.mealPeriod.label),
              style: style.text.reverse_neutral.merge(style.fontsize.xs),
            ),
          ],
        ),
      ),
    );
  }
}
