import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/CustomCard.widget.dart';
import 'package:kali/core/models/NutriScore.model.dart';
import 'package:kali/core/states/startForm.state.dart';

class TotalCaloriesWidget extends StatefulWidget {
  const TotalCaloriesWidget({super.key});

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
    NutriScore? personalNutriScore =
        context.watch<StartFormState>().personalNutriScore.value;

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
          if (personalNutriScore?.caloryAmount != null)
            Text(
              personalNutriScore!.caloryAmount.toString(),
              textAlign: TextAlign.start,
              style: style.text.neutral.merge(style.fontsize.sm),
            ),
        ],
      ),
    );
  }
}
