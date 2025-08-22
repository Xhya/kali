import 'package:flutter/material.dart';
import 'package:kali/client/widgets/DateInput.widget.dart';
import 'package:kali/core/states/startForm.state.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/CustomSelect.widget.dart';

class StartFormPage2 extends StatefulWidget {
  const StartFormPage2({super.key});

  @override
  State<StartFormPage2> createState() => _StartFormPage2State();
}

class _StartFormPage2State extends State<StartFormPage2> {
  @override
  Widget build(BuildContext context) {
    SelectOption? genderOption =
        context.select((StartFormState s) => s.genderOption.value);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12),
            Text(
              "Tes informations personnelles 🩺",
              style: style.text.neutral.merge(style.fontsize.lg),
            ),
            SizedBox(height: 4),
            Text(
              "Ces infos nous aident à calculer ton métabolisme de base avec précision.",
              style: style.text.neutral.merge(style.fontsize.xs),
            ),

            SizedBox(height: 44),

            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "Ta date de naissance",
                style: style.text.neutral.merge(style.fontsize.sm),
              ),
            ),
            DateInputWidget(
              onUpdateDate: (String value) {
                startFormState.birthdate.value = value;
              },
            ),

            SizedBox(height: 32),

            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "Ton sexe",
                style: style.text.neutral.merge(style.fontsize.sm),
              ),
            ),

            CustomSelectWidget(
              onChanged: (SelectOption? value) {
                startFormState.genderOption.value = value;
              },
              options: [
                SelectOption(
                  value: "woman",
                  label: "Femme",
                  icon: Icon(Icons.female),
                ),
                SelectOption(
                  value: "man",
                  label: "Homme",
                  icon: Icon(Icons.male),
                ),
                SelectOption(
                  value: "other",
                  label: "Autre",
                  icon: Icon(Icons.apple),
                ),
              ],
              selected: genderOption,
            ),
          ],
        ),
      ),
    );
  }
}
