import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/EmailInput.widget.dart';
import 'package:kali/client/widgets/MainButton.widget.dart';
import 'package:kali/client/widgets/PasswordInput.widget.dart';
import 'package:kali/core/actions/confetti.actions.dart';
import 'package:kali/core/domains/authentication.repository.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/services/User.service.dart';
import 'package:kali/core/states/Input.state.dart';
import 'package:kali/core/states/register.state.dart';

Future<void> onSubmitLogin() async {
  try {
    await AuthenticationRepository().login(
      email: inputState.email.value,
      password: inputState.password.value,
    );
    await userService.refreshUser();
    navigationService.navigateBack();
    navigationService.navigateTo(ScreenEnum.home);
    launchConfetti();
  } catch (e, stack) {
    final extractedMessage = errorService.extractCurrentErrorMessage();
    registerState.error.value = extractedMessage;
    errorService.notifyError(e: e, stack: stack, show: false);
  }
}

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
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

    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "Ravie de te revoir 👋🏼",
            style: style.fontsize.lg
                .merge(style.text.neutral)
                .merge(style.fontweight.bold),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 4),
          Text(
            "Il est temps de se remettre en route vers le changement ",
            style: style.fontsize.sm.merge(style.text.neutralLight),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 32),
          EmailInputWidget(),
          SizedBox(height: 4),
          PasswordInputWidget(),
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
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MainButtonWidget(
                onClick: () {
                  navigationService.context = context;
                  onSubmitLogin();
                },
                text: "se connecter",
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
