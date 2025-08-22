import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/Utils/InputWithTextFormatter.utils.dart';
import 'package:kali/client/Utils/MaxDigitsCountFormatter.utils.dart';
import 'package:kali/client/widgets/CustomIcon.widget.dart';
import 'package:kali/client/widgets/CustomInput.dart';
import 'package:kali/core/actions/startForm.actions.dart';
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
    String height = context.select((StartFormState s) => s.height.value);
    String weight = context.select((StartFormState s) => s.weight.value);

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
                MaxDigitsCountFormatter(maxLength: 3),
              ],
              customIcon: CustomIconWidget(
                format: CustomIconFormat.svg,
                icon: "assets/icons/regle.svg",
              ),
              keyboardType: TextInputType.datetime,
              textInputAction: TextInputAction.next,
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
                MaxDigitsCountFormatter(maxLength: 3),
              ],
              customIcon: CustomIconWidget(
                format: CustomIconFormat.svg,
                icon: "assets/icons/balance.svg",
              ),
              suffixIcon: Icon(Icons.rule),
              keyboardType: TextInputType.datetime,
              textInputAction: TextInputAction.next,
              onSubmitted: (value) {
                onClickNext();
              },
            ),
          ],
        ),
      ),
    );
  }
}
