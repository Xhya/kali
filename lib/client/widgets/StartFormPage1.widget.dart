import 'package:flutter/material.dart';
import 'package:kali/client/states/startForm.state.dart';
import 'package:kali/core/services/Translation.service.dart';
import 'package:kali/core/utils/formatters.utils.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/widgets/CustomInput.dart';

class StartFormPage1 extends StatefulWidget {
  const StartFormPage1({super.key});

  @override
  State<StartFormPage1> createState() => _StartFormPage1State();
}

class _StartFormPage1State extends State<StartFormPage1> {
  @override
  Widget build(BuildContext context) {
    String age = context.watch<StartFormState>().age.value;
    String weight = context.watch<StartFormState>().weight.value;
    String size = context.watch<StartFormState>().size.value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Faison un peu connaissance"),
        SizedBox(height: 8),
        CustomInput(
          content: size,
          onChanged: (String value) {
            startFormState.size.value = value;
          },
          suffixText: "cm",
          placeholder: t("size"),
          inputFormatters: [onlyNumbersFormatter()],
        ),
        SizedBox(height: 32),
        CustomInput(
          content: weight,
          onChanged: (value) {
            startFormState.weight.value = value;
          },
          suffixText: "kg",
          placeholder: t("weight"),
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
    );
  }
}
