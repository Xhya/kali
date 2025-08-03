import 'package:flutter/material.dart';
import 'package:kali/core/services/Authentication.service.dart';
import 'package:kali/core/states/register.state.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/MainButton.widget.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:sms_autofill/sms_autofill.dart';

onSubmitCode() async {
  try {
    registerState.isLoading.value = true;
    await authenticationService.verifyAuthCode(registerState.code.value);
    navigationService.navigateBack();
  } catch (e, stack) {
    navigationService.navigateBack();
    errorService.notifyError(e: e, stack: stack);
  } finally {
    registerState.isLoading.value = false;
  }
}

class ValidateCodeWidget extends StatefulWidget {
  const ValidateCodeWidget({super.key, required this.text});

  final String text;

  @override
  State<ValidateCodeWidget> createState() => _ValidateCodeWidgetState();
}

class _ValidateCodeWidgetState extends State<ValidateCodeWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final code = context.select((RegisterState v) => v.code.value);
    final isLoading = context.select((RegisterState v) => v.isLoading.value);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            widget.text,
            style: style.fontsize.sm.merge(style.text.neutralLight),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 32),
        Container(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
              maxHeight: double.infinity,
              maxWidth: 400,
            ),
            child: PinFieldAutoFill(
              currentCode: code,
              codeLength: 6,
              onCodeChanged: (String? newCode) {
                registerState.code.value = newCode ?? "";
                if (registerState.code.value.length == 6) {
                  navigationService.context = context;
                  onSubmitCode();
                }
              },
              decoration: UnderlineDecoration(
                textStyle: TextStyle(
                  color: style.text.neutral.color,
                  fontSize: style.fontsize.lg.fontSize,
                ),
                colorBuilder: FixedColorBuilder(
                  style.border.color.color1.color!,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 32),
        MainButtonWidget(
          onClick: () {
            navigationService.context = context;
            onSubmitCode();
          },
          text: "Valider",
          iconWidget: Icon(Icons.arrow_forward, size: 20),
          disabled: code.length < 6,
          isLoading: isLoading,
        ),
      ],
    );
  }
}
