import 'package:flutter/material.dart';
import 'package:kali/core/services/Translation.service.dart';
import 'package:kali/core/states/user.state.dart';
import 'package:kali/core/utils/macroIcon.utils.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/CustomCard.widget.dart';
import 'package:kali/core/models/NutriScore.model.dart';

class TotalNutriScoresWidget extends StatefulWidget {
  const TotalNutriScoresWidget({super.key});

  @override
  State<TotalNutriScoresWidget> createState() => _TotalNutriScoresWidgetState();
}

class _TotalNutriScoresWidgetState extends State<TotalNutriScoresWidget> {
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
        context.watch<UserState>().personalNutriscore;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      spacing: 4,
      children: [
        Expanded(
          child: CustomCard(
            child: Column(
              children: [
                SizedBox(height: 12),
                Text(
                  proteinIcon,
                  style: style.fontsize.xl.merge(style.text.neutral),
                ),
                Text(
                  "${personalNutriScore!.proteinAmount}gr",
                  style: style.fontsize.sm
                      .merge(style.text.neutral)
                      .merge(style.fontweight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  t('proteins').toLowerCase(),
                  style: style.fontsize.sm.merge(style.text.neutral),
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
        ),
        Expanded(
          child: CustomCard(
            child: Column(
              children: [
                SizedBox(height: 12),
                Text(
                  lipidIcon,
                  style: style.fontsize.xl.merge(style.text.neutral),
                ),
                Text(
                  "${personalNutriScore.glucidAmount}gr",
                  style: style.fontsize.sm
                      .merge(style.text.neutral)
                      .merge(style.fontweight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  t('glucids').toLowerCase(),
                  style: style.fontsize.sm.merge(style.text.neutral),
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
        ),
        Expanded(
          child: CustomCard(
            child: Column(
              children: [
                SizedBox(height: 12),
                Text(
                  glucidIcon,
                  style: style.fontsize.xl.merge(style.text.neutral),
                ),
                Text(
                  "${personalNutriScore.lipidAmount}gr",
                  style: style.fontsize.sm
                      .merge(style.text.neutral)
                      .merge(style.fontweight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  t('lipids').toLowerCase(),
                  style: style.fontsize.sm.merge(style.text.neutral),
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
