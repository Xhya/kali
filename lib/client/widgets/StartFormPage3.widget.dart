import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/Utils/InputWithTextFormatter.utils.dart';
import 'package:kali/client/widgets/CustomInput.dart';
import 'package:kali/core/utils/formatters.utils.dart';
import 'package:provider/provider.dart';
import 'package:kali/core/states/startForm.state.dart';
import 'package:kali/client/widgets/CustomSelect.widget.dart';

class StartFormPage3 extends StatefulWidget {
  const StartFormPage3({super.key});

  @override
  State<StartFormPage3> createState() => _StartFormPage3State();
}

class _StartFormPage3State extends State<StartFormPage3> {
  @override
  Widget build(BuildContext context) {
    SelectOption? objectiveOption =
        context.watch<StartFormState>().objectiveOption.value;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12),
            Text(
              "Tes données corporelles ⚖️",
              style: style.text.neutral.merge(style.fontsize.lg),
            ),
            SizedBox(height: 4),

            Text(
              "On s'appuie dessus pour ajuster ton plan personnalisé.",
              style: style.text.neutral.merge(style.fontsize.xs),
            ),

            SizedBox(height: 24),

            CustomInput(
              content: null,
              onChanged: (String value) {},
              placeholder: "170 cm",
              inputFormatters: [
                onlyNumbersFormatter(),
                InputWithTextFormatter(extension: "cm"),
              ],
              suffixIcon: Icon(Icons.rule),
            ),

            SizedBox(height: 4),

            CustomInput(
              content: null,
              onChanged: (String value) {},
              placeholder: "70 kg",
              inputFormatters: [
                onlyNumbersFormatter(),
                InputWithTextFormatter(extension: "kg"),
              ],
              suffixIcon: Icon(Icons.rule),
            ),

            SizedBox(height: 32),

            CustomInput(
              title: "Ton poids cible",
              content: null,
              onChanged: (String value) {},
              placeholder: "70 kg",
              inputFormatters: [
                onlyNumbersFormatter(),
                InputWithTextFormatter(extension: "kg"),
              ],
              suffixIcon: Icon(Icons.rule),
            ),

            SizedBox(height: 32),

            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "Résultats",
                style: style.text.neutral.merge(style.fontsize.sm),
              ),
            ),

            CustomSelectWidget(
              onChanged: (SelectOption? value) {
                startFormState.objectiveOption.value = value;
              },
              options: [
                SelectOption(
                  value: "woman",
                  label: "Rapide",
                  icon: Icon(Icons.abc),
                ),
                SelectOption(
                  value: "man",
                  label: "Normaux",
                  icon: Icon(Icons.alternate_email),
                ),
              ],
              selected: objectiveOption,
            ),
          ],
        ),
      ),
    );
  }
}
