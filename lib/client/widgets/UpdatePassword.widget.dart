import 'package:flutter/material.dart';
import 'package:kali/client/widgets/CustomIcon.widget.dart';
import 'package:kali/client/widgets/CustomInput.dart';
import 'package:kali/client/widgets/PasswordInput.widget.dart';
import 'package:kali/repository/authentication.repository.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/Translation.service.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/MainButton.widget.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/states/Input.state.dart';
import 'package:kali/core/states/register.state.dart';

Future<void> onSubmitUpdatePassword(String newPassword) async {
  try {
    await AuthenticationRepository().updatePasswordRequest(
      newPassword: newPassword,
      oldPassword: inputState.password.value,
    );
    navigationService.closeBottomSheet();
  } catch (e, stack) {
    errorService.notifyError(e: e, stack: stack);
  }
}

class UpdatePasswordWidget extends StatefulWidget {
  const UpdatePasswordWidget({super.key});

  @override
  State<UpdatePasswordWidget> createState() => _UpdatePasswordWidgetState();
}

class _UpdatePasswordWidgetState extends State<UpdatePasswordWidget> {
  bool obscurePassword = true;

  @override
  void initState() {
    super.initState();
    inputState.reset();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final error = context.select((RegisterState v) => v.error.value);
    var newPassword = "";

    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            t('change_password'),
            style: style.fontsize.lg
                .merge(style.text.neutral)
                .merge(style.fontweight.bold),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              t('your_old_password'),
              style: style.text.neutral.merge(style.fontsize.sm),
            ),
          ),
          PasswordInputWidget(),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              t('your_new_password'),
              style: style.text.neutral.merge(style.fontsize.sm),
            ),
          ),
          CustomInput(
            onChanged: (value) {
              newPassword = value;
            },
            placeholder: t('new_password'),
            customIcon: CustomIconWidget(
              icon: Icon(
                obscurePassword ? Icons.visibility_off : Icons.visibility,
              ),
              onClick: () {
                setState(() {
                  obscurePassword = !obscurePassword;
                });
              },
            ),
            obscureText: obscurePassword,
          ),

          if (error != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                registerState.error.value!,
                style: style.text.error.merge(style.fontsize.sm),
              ),
            ),
          SizedBox(height: 32),
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MainButtonWidget(
                onClick: () {
                  onSubmitUpdatePassword(newPassword);
                },
                text: "Mettre à jour",
                iconWidget: Icon(Icons.arrow_forward, size: 20),
                disabled: false,
                isLoading: false,
              ),
            ],
          ),
          SizedBox(height: 40),
          // Row(
          //   spacing: 8,
          //   children: [
          //     Expanded(
          //       child: Container(
          //         decoration: BoxDecoration(
          //           border: Border.all(color: style.border.color.color2.color!),
          //         ),
          //       ),
          //     ),
          //     Text(
          //       "Ou se connecter via",
          //       style: style.fontsize.sm.merge(style.text.neutralLight),
          //       textAlign: TextAlign.center,
          //     ),
          //     Expanded(
          //       child: Container(
          //         decoration: BoxDecoration(
          //           border: Border.all(color: style.border.color.color2.color!),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // SizedBox(height: 12),
          // GoogleSignInButton(action: 'login'),
        ],
      ),
    );
  }
}
