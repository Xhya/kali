import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/MealPeriodTag.widget.dart';
import 'package:kali/core/models/Meal.model.dart';
import 'package:kali/core/services/Datetime.extension.dart';

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
      spacing: 8,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.meal.mealDescription != null)
                Text(
                  widget.meal.mealDescription!,
                  style: style.fontsize.sm.merge(style.text.neutral),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              Text(
                widget.meal.createdAt?.formateDate("hh:mm") ?? "TOTO",
                style: style.fontsize.sm.merge(style.text.neutral),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        if (widget.meal.period != null)
          MealPeriodTagWidget(mealPeriod: widget.meal.period!),
        // if (widget.meal.nutriScore != null)
        //   Text(
        //     "${widget.meal.nutriScore!.caloryAmount} kcal",
        //     style: style.fontsize.md
        //         .merge(style.text.reverse_neutral)
        //         .merge(style.fontweight.bold),
        //   ),
      ],
    );
  }
}
