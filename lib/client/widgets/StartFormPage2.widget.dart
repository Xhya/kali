import 'package:flutter/material.dart';
import 'package:kali/client/Utils/InputWithTextFormatter.utils.dart';
import 'package:kali/client/Utils/MaxDigitsCountFormatter.utils.dart';
import 'package:kali/client/Utils/OnlyNumbersFormatter.utils.dart';
import 'package:kali/client/widgets/CustomIcon.widget.dart';
import 'package:kali/client/widgets/CustomInput.dart';
import 'package:kali/core/actions/startForm.actions.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/states/startForm.state.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';

class StartFormPage2 extends StatefulWidget {
  const StartFormPage2({super.key});

  @override
  State<StartFormPage2> createState() => _StartFormPage2State();
}

class _StartFormPage2State extends State<StartFormPage2> {
  @override
  Widget build(BuildContext context) {
    String weight = context.select((StartFormState s) => s.weight.value);
    String height = context.select((StartFormState s) => s.height.value);
    String targetWeight = context.select(
      (StartFormState s) => s.targetWeight.value,
    );
    bool isNextButtonDisabled =
        context.watch<StartFormState>().isNextButtonDisabled;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12),
            Text(
              "Ton objectif 🎯",
              style: style.text.neutral.merge(style.fontsize.lg),
            ),
            SizedBox(height: 4),
            Text(
              "Visualise ton objectif, et avance avec Kali, un jour à la fois.",
              style: style.text.neutral.merge(style.fontsize.xs),
            ),

            SizedBox(height: 32),

            CustomInput(
              title: "Ton poids actuel",
              content: weight,
              onChanged: (String value) {
                startFormState.weight.value = value;
              },
              placeholder: "70 kg",
              inputFormatters: [
                onlyNumbersFormatter(),
                InputWithTextFormatter(extension: "kg"),
                MaxDigitsCountFormatter(maxLength: 3),
              ],
              customIcon: CustomIconWidget(
                format: CustomIconFormat.svg,
                icon: "assets/icons/balance.svg",
              ),
              keyboardType: TextInputType.datetime,
              textInputAction: TextInputAction.next,
            ),

            SizedBox(height: 8),

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
            ),

            SizedBox(height: 32),

            CustomInput(
              title: "Ta taille",
              content: height,
              onChanged: (String value) {
                startFormState.height.value = value;
              },
              placeholder: "170 cm",
              inputFormatters: [
                onlyNumbersFormatter(),
                InputWithTextFormatter(extension: "cm"),
                MaxDigitsCountFormatter(maxLength: 3),
              ],
              customIcon: CustomIconWidget(
                format: CustomIconFormat.svg,
                icon: "assets/icons/regle.svg",
              ),
              keyboardType: TextInputType.datetime,
              textInputAction: TextInputAction.done,
              onSubmitted: (value) {
                if (!isNextButtonDisabled) {
                  onClickNext();
                }
              },
            ),
            SizedBox(height: 400),
          ],
        ),
      ),
    );
  }
}
