import 'package:flutter/material.dart';
import 'package:kalori/client/Style.service.dart';
import 'package:kalori/client/widgets/CustomCard.widget.dart';
import 'package:kalori/core/models/NutriScore.model.dart';
import 'package:kalori/core/utils/macroIcon.utils.dart';

class NutriScore2by2Widget extends StatefulWidget {
  const NutriScore2by2Widget({super.key, required this.nutriScore});

  final NutriScore? nutriScore;

  @override
  State<NutriScore2by2Widget> createState() => _NutriScore2by2WidgetState();
}

class _NutriScore2by2WidgetState extends State<NutriScore2by2Widget> {
  var isExpanded = false;

  @override
  void initState() {
    setState(() {
      isExpanded = true;
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        CustomCard(
          child: SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width / 2 - 12 * 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "$caloryIcon calories",
                  style: style.text.reverse_neutral.merge(style.fontsize.sm),
                ),
                Text(
                  widget.nutriScore == null
                      ? "-"
                      : widget.nutriScore!.caloryAmount.toString(),
                  style: style.text.reverse_neutral.merge(style.fontsize.sm),
                ),
              ],
            ),
          ),
        ),
        CustomCard(
          child: SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width / 2 - 12 * 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "$glucidIcon glucides",
                  style: style.text.reverse_neutral.merge(style.fontsize.sm),
                ),
                Text(
                  widget.nutriScore == null
                      ? "-"
                      : widget.nutriScore!.glucidAmount.toString(),
                  style: style.text.reverse_neutral.merge(style.fontsize.sm),
                ),
              ],
            ),
          ),
        ),
        CustomCard(
          child: SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width / 2 - 12 * 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "$proteinIcon protéines",
                  style: style.text.reverse_neutral.merge(style.fontsize.sm),
                ),
                Text(
                  widget.nutriScore == null
                      ? "-"
                      : widget.nutriScore!.proteinAmount.toString(),
                  style: style.text.reverse_neutral.merge(style.fontsize.sm),
                ),
              ],
            ),
          ),
        ),
        CustomCard(
          child: SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width / 2 - 12 * 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "$lipidIcon lipides",
                  style: style.text.reverse_neutral.merge(style.fontsize.sm),
                ),
                Text(
                  widget.nutriScore == null
                      ? "-"
                      : widget.nutriScore!.lipidAmount.toString(),
                  style: style.text.reverse_neutral.merge(style.fontsize.sm),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
