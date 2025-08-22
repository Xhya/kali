import 'package:flutter/material.dart';
import 'package:kali/client/Utils/InputWithTextFormatter.utils.dart';
import 'package:kali/client/Utils/MaxDigitsCountFormatter.utils.dart';
import 'package:kali/client/widgets/CustomIcon.widget.dart';
import 'package:kali/client/widgets/CustomInput.dart';
import 'package:kali/core/actions/startForm.actions.dart';
import 'package:kali/core/states/startForm.state.dart';
import 'package:kali/core/utils/formatters.utils.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';

class StartFormPage4 extends StatefulWidget {
  const StartFormPage4({super.key});

  @override
  State<StartFormPage4> createState() => _StartFormPage4State();
}

class _StartFormPage4State extends State<StartFormPage4> {
  @override
  Widget build(BuildContext context) {
    String targetWeight = context.select(
      (StartFormState s) => s.targetWeight.value,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12),
            Text(
              "Quel est ton objectif ? 🎯",
              style: style.text.neutral.merge(style.fontsize.lg),
            ),
            SizedBox(height: 4),

            Text(
              "Kali s'adapte à ce que tu veux vraiment atteindre.",
              style: style.text.neutral.merge(style.fontsize.xs),
            ),

            SizedBox(height: 32),

            CustomInput(
              title: "Ton poids cible",
              content: targetWeight,
              onChanged: (String value) {
                startFormState.targetWeight.value = value;
              },
              placeholder: "70 kg",
              inputFormatters: [
                onlyNumbersFormatter(),
                InputWithTextFormatter(extension: "kg"),
                MaxDigitsCountFormatter(maxLength: 3),
              ],
              customIcon: CustomIconWidget(
                format: CustomIconFormat.svg,
                icon: "assets/icons/cible.svg",
              ),
              keyboardType: TextInputType.datetime,
              textInputAction: TextInputAction.next,
              onSubmitted: (value) {
                onClickNext();
              },
            ),
          ],
        ),
      ),
    );
  }
}
