import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kali/core/services/Translation.service.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/widgets/CustomIcon.widget.dart';
import 'package:kali/client/widgets/CustomInput.dart';
import 'package:kali/client/widgets/ValidateCode.widget.dart';
import 'package:kali/core/domains/authentication.repository.dart';
import 'package:kali/core/states/register.state.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/EmailInput.widget.dart';
import 'package:kali/client/widgets/Login.widget.dart';
import 'package:kali/client/widgets/MainButton.widget.dart';
import 'package:kali/client/widgets/PasswordInput.widget.dart';
import 'package:kali/client/widgets/WelcomeBottomSheet.widget.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/states/Input.state.dart';

Future<void> onSubmitRegisterUser() async {
  try {
    registerState.isLoading.value = true;
    await AuthenticationRepository().register(
      email: inputState.email.value,
      password: inputState.password.value,
    );
    navigationService.navigateBack();
    await Future.delayed(const Duration(milliseconds: 100));
    navigationService.openBottomSheet(
      widget: WelcomeBottomSheet(
        child: ValidateCodeWidget(
          text: "Veuillez entrez le code que vous avez reçu par email",
        ),
      ),
    );
  } catch (e, stack) {
    final extractedMessage = errorService.extractCurrentErrorMessage();
    registerState.error.value = extractedMessage;
    errorService.notifyError(e: e, stack: stack, show: false);
  } finally {
    registerState.isLoading.value = false;
  }
}

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key, required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  String passwordCopy = "";
  bool obscurePassword = true;

  @override
  void initState() {
    registerState.isLoading.value = false;
    registerState.error.value = null;
    super.initState();
    inputState.reset();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool areEmailAndPasswordValid =
        context.watch<InputState>().areEmailAndPasswordValid;
    final isLoading = context.select((RegisterState v) => v.isLoading.value);
    final error = context.select((RegisterState v) => v.error.value);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          widget.title,
          style: style.fontsize.lg
              .merge(style.text.neutral)
              .merge(style.fontweight.bold),
          textAlign: TextAlign.center,
        ),
        if (widget.subtitle != null) SizedBox(height: 4),
        if (widget.subtitle != null)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              widget.subtitle!,
              style: style.fontsize.sm.merge(style.text.neutralLight),
              textAlign: TextAlign.center,
            ),
          ),
        SizedBox(height: 32),
        EmailInputWidget(),
        SizedBox(height: 4),
        PasswordInputWidget(),
        SizedBox(height: 4),
        CustomInput(
          content: passwordCopy,
          onChanged: (value) {
            setState(() {
              passwordCopy = value;
            });
          },
          placeholder: t('repeat_password'),
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
        SizedBox(height: 4),
        if (error != null)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              registerState.error.value!,
              style: style.text.error.merge(style.fontsize.sm),
            ),
          ),
        SizedBox(height: 32),
        MainButtonWidget(
          onClick: () {
            onSubmitRegisterUser();
          },
          text: "créer un compte",
          iconWidget: Icon(Icons.arrow_forward, size: 20),
          disabled:
              !areEmailAndPasswordValid ||
              passwordCopy != inputState.password.value,
          isLoading: isLoading,
        ),
        // SizedBox(height: 40),
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
        // SizedBox(height: 8),
        // GoogleSignInButton(action: 'register'),
        SizedBox(height: 32),
        Row(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Tu as déjà un compte ?",
              style: style.fontsize.sm.merge(style.text.neutralLight),
            ),
            GestureDetector(
              onTap: () async {
                navigationService.navigateBack();
                await Future.delayed(Duration(milliseconds: 400), () {
                  registerState.error.value = null;
                  navigationService.openBottomSheet(
                    widget: WelcomeBottomSheet(child: LoginWidget()),
                  );
                });
              },
              child: Text(
                "se connecter",
                style: style.fontsize.sm
                    .merge(style.text.neutralLight)
                    .merge(TextStyle(decoration: TextDecoration.underline))
                    .merge(style.fontweight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
