import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12),
            Text(
              "Quel est ton objectif principal ?",
              style: style.text.neutral.merge(style.fontsize.lg),
            ),
            SizedBox(height: 16),
            CustomSelectWidget(
              onChanged: (SelectOption? value) {
                startFormState.objectiveOption.value = value;
              },
              options: [
                SelectOption(
                  value: "woman",
                  label: "Perdre du poids",
                  icon: Icon(Icons.abc),
                ),
                SelectOption(
                  value: "man",
                  label: "Prendre du muscle",
                  icon: Icon(Icons.alternate_email),
                ),
                SelectOption(
                  value: "other",
                  label: "Garder la forme",
                  icon: Icon(Icons.apple),
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
