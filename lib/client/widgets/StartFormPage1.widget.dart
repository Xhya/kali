import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/CustomIcon.widget.dart';
import 'package:kali/client/widgets/CustomSelect.widget.dart';
import 'package:kali/client/widgets/DateInput.widget.dart';
import 'package:kali/core/actions/startForm.actions.dart';
import 'package:kali/core/states/startForm.state.dart';
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
    String userName = context.select((StartFormState s) => s.userName.value);
    SelectOption? genderOption = context.select(
      (StartFormState s) => s.genderOption.value,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12),
            Text(
              "Tes infos personnelles 👋🏼",
              style: style.text.neutral.merge(style.fontsize.lg),
            ),
            SizedBox(height: 4),
            Text(
              "Donne-moi ces quelques infos pour un suivi qui te ressemble.",
              style: style.text.neutral.merge(style.fontsize.xs),
            ),

            SizedBox(height: 32),

            CustomInput(
              title: "Ton nom d'utilisateur",
              content: userName,
              onChanged: (String value) {
                startFormState.userName.value = value;
              },
              placeholder: "Mama kitchen",
              customIcon: CustomIconWidget(
                format: CustomIconFormat.svg,
                icon: "assets/icons/user.svg",
              ),
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.next,
            ),

            SizedBox(height: 32),

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
                  icon: CustomIconWidget(
                    format: CustomIconFormat.svg,
                    icon: "assets/icons/femme.svg",
                  ),
                ),
                SelectOption(
                  value: "man",
                  label: "Homme",
                  icon: CustomIconWidget(
                    format: CustomIconFormat.svg,
                    icon: "assets/icons/homme.svg",
                  ),
                ),
                SelectOption(
                  value: "other",
                  label: "Autre",
                  icon: CustomIconWidget(
                    format: CustomIconFormat.svg,
                    icon: "assets/icons/gender-x.svg",
                  ),
                ),
              ],
              selected: genderOption,
            ),
            SizedBox(height: 400),
          ],
        ),
      ),
    );
  }
}
