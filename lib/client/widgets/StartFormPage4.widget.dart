import 'package:flutter/material.dart';
import 'package:kali/client/widgets/CustomSelect.widget.dart';
import 'package:kali/core/states/startForm.state.dart';
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
    String age = context.watch<StartFormState>().age.value;
    String weight = context.watch<StartFormState>().weight.value;

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
              selected: null,
            ),
          ],
        ),
      ),
    );
  }
}
