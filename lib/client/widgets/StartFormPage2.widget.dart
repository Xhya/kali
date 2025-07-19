import 'package:flutter/material.dart';
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
    SelectOption? genderOption = context.watch<StartFormState>().genderOption.value;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12),
            Text(
              "Rentrons un peu dans les détails",
              style: style.text.neutral.merge(style.fontsize.lg),
            ),
            SizedBox(height: 16),
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
