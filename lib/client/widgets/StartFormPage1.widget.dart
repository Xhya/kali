import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/CustomIcon.widget.dart';
import 'package:kali/client/widgets/CustomSelect.widget.dart';
import 'package:kali/client/widgets/DateInput.widget.dart';
import 'package:kali/core/services/Translation.service.dart';
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
              t('startformpage1_title'),
              style: style.text.neutral.merge(style.fontsize.lg),
            ),
            SizedBox(height: 4),
            Text(
              t('startformpage1_subtitle'),
              style: style.text.neutral.merge(style.fontsize.xs),
            ),

            SizedBox(height: 32),

            CustomInput(
              title: t('your_user_name'),
              content: userName,
              onChanged: (String value) {
                startFormState.userName.value = value;
              },
              placeholder: t('your_user_name_placeholder'),
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
                t('your_birthdate'),
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
                t('your_gender'),
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
                  label: t('woman'),
                  icon: CustomIconWidget(
                    format: CustomIconFormat.svg,
                    icon: "assets/icons/femme.svg",
                  ),
                ),
                SelectOption(
                  value: "man",
                  label: t('man'),
                  icon: CustomIconWidget(
                    format: CustomIconFormat.svg,
                    icon: "assets/icons/homme.svg",
                  ),
                ),
                SelectOption(
                  value: "other",
                  label: t('other'),
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
