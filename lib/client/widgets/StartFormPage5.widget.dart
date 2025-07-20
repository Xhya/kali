import 'package:flutter/material.dart';
import 'package:kali/client/widgets/CustomSelect.widget.dart';
import 'package:kali/core/states/startForm.state.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';

class StartFormPage5 extends StatefulWidget {
  const StartFormPage5({super.key});

  @override
  State<StartFormPage5> createState() => _StartFormPage5State();
}

class _StartFormPage5State extends State<StartFormPage5> {
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
              "Ton rythme de vie 🔄",
              style: style.text.neutral.merge(style.fontsize.lg),
            ),
            SizedBox(height: 4),

            Text(
              "Dis-moi comment tu bouges au quotidien, je m'occupe du reste.",
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
                  label: "Principalement assis",
                  icon: Icon(Icons.abc),
                ),
                SelectOption(
                  value: "man",
                  label: "Principalement debout",
                  icon: Icon(Icons.alternate_email),
                ),
                SelectOption(
                  value: "other",
                  label: "Très actif",
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
