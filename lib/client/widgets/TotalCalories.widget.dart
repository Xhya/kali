import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/CustomCard.widget.dart';
import 'package:kali/core/models/NutriScore.model.dart';

class TotalCaloriesWidget extends StatefulWidget {
  const TotalCaloriesWidget({super.key, required this.nutriScore});

  final NutriScore nutriScore;

  @override
  State<TotalCaloriesWidget> createState() => _TotalCaloriesWidgetState();
}

class _TotalCaloriesWidgetState extends State<TotalCaloriesWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: EdgeInsets.all(16),
      child: Row(
        spacing: 12,
        children: [
          Text(
            "⚖️",
            textAlign: TextAlign.start,
            style: style.text.green
                .merge(style.fontsize.md)
                .merge(style.fontweight.bold),
          ),

          Expanded(
            child: Text(
              "calories",
              textAlign: TextAlign.start,
              style: style.text.neutral.merge(style.fontsize.sm),
            ),
          ),
          Text(
            widget.nutriScore.caloryAmount.toString(),
            textAlign: TextAlign.start,
            style: style.text.neutral.merge(style.fontsize.sm),
          ),
        ],
      ),
    );
  }
}
