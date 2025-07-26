import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/Utils/InputWithTextFormatter.utils.dart';
import 'package:kali/client/Utils/MaxCharactersCountFormatter.utils.dart';
import 'package:kali/client/widgets/CustomInput.dart';
import 'package:kali/core/utils/formatters.utils.dart';
import 'package:provider/provider.dart';
import 'package:kali/core/states/startForm.state.dart';

class StartFormPage3 extends StatefulWidget {
  const StartFormPage3({super.key});

  @override
  State<StartFormPage3> createState() => _StartFormPage3State();
}

class _StartFormPage3State extends State<StartFormPage3> {
  @override
  Widget build(BuildContext context) {
    String height = context.watch<StartFormState>().height.value;
    String weight = context.watch<StartFormState>().weight.value;

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
              content: height,
              onChanged: (String value) {
                startFormState.height.value = value;
              },
              placeholder: "170 cm",
              inputFormatters: [
                onlyNumbersFormatter(),
                InputWithTextFormatter(extension: "cm"),
                MaxCharactersCountFormatter(maxLength: 3),
              ],
              suffixIcon: Icon(Icons.rule),
            ),

            SizedBox(height: 4),

            CustomInput(
              content: weight,
              onChanged: (String value) {
                startFormState.weight.value = value;
              },
              placeholder: "70 kg",
              inputFormatters: [
                onlyNumbersFormatter(),
                InputWithTextFormatter(extension: "kg"),
                MaxCharactersCountFormatter(maxLength: 3),
              ],
              suffixIcon: Icon(Icons.rule),
            ),
          ],
        ),
      ),
    );
  }
}
