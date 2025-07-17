import 'package:flutter/material.dart';
import 'package:kali/client/states/startForm.state.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/CustomInput.dart';
import 'package:kali/core/services/Translation.service.dart';
import 'package:kali/core/utils/formatters.utils.dart';

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
              "Où en es-tu actuellement ?",
              style: style.text.neutral.merge(style.fontsize.lg),
            ),
            SizedBox(height: 16),

            CustomInput(
              title: "Ta taille",
              content: "size",
              onChanged: (String value) {},
              placeholder: "170cm",
              inputFormatters: [onlyNumbersFormatter()],
            ),
            SizedBox(height: 32),
            CustomInput(
              content: age,
              onChanged: (value) {
                startFormState.age.value = value;
              },
              suffixText: "ans",
              placeholder: t("age"),
              inputFormatters: [onlyNumbersFormatter()],
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
