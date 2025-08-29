import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/CustomIcon.widget.dart';
import 'package:kali/client/widgets/CustomInput.dart';
import 'package:kali/core/actions/startForm.actions.dart';
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
    String leitmotiv = context.select((StartFormState s) => s.leitmotiv.value);
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
              "Ton pourquoi 🎯",
              style: style.text.neutral.merge(style.fontsize.lg),
            ),
            SizedBox(height: 4),

            Text(
              "Rappelle‑toi pourquoi tu avances : c’est ton moteur au quotidien.",
              style: style.text.neutral.merge(style.fontsize.xs),
            ),

            SizedBox(height: 32),

            CustomInput(
              title: "Ton leitmotiv",
              content: leitmotiv,
              onChanged: (String value) {
                startFormState.leitmotiv.value = value;
              },
              placeholder: "Je veux me prouver...",
              customIcon: CustomIconWidget(
                format: CustomIconFormat.svg,
                icon: "assets/icons/stylo.svg",
              ),
              minLines: 4,
              maxLines: 10,
              textCapitalization: TextCapitalization.sentences,
              onSubmitted: (String value) {
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
