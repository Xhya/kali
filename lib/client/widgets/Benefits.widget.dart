import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';

class BenefitsWidget extends StatefulWidget {
  const BenefitsWidget({super.key});

  @override
  State<BenefitsWidget> createState() => _BenefitsWidgetState();
}

class _BenefitsWidgetState extends State<BenefitsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "🍜 Créer de bonnes habitudes",
          textAlign: TextAlign.start,
          style: style.fontsize.sm.merge(style.text.neutral),
        ),
        SizedBox(height: 8),
        Text(
          "🍕 Suivre d'un rapide coup d'oeil sa journée",
          textAlign: TextAlign.start,
          style: style.fontsize.sm.merge(style.text.neutral),
        ),
        SizedBox(height: 8),
        Text(
          "🧘🏻‍♀️ Conscientiser son alimentation",
          textAlign: TextAlign.start,
          style: style.fontsize.sm.merge(style.text.neutral),
        ),
        SizedBox(height: 8),
        Text(
          "👌🏻 Alléger sa charge mentale",
          textAlign: TextAlign.start,
          style: style.fontsize.sm.merge(style.text.neutral),
        ),
      ],
    );
  }
}
