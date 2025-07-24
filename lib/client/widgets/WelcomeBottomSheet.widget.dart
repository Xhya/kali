import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/CustomInkwell.widget.dart';
import 'package:kali/client/widgets/EmailInput.widget.dart';
import 'package:kali/client/widgets/MainButton.widget.dart';
import 'package:kali/client/widgets/PasswordInput.widget.dart';
import 'package:kali/core/domains/user.repository.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/states/Input.state.dart';
import 'package:kali/core/utils/paths.utils.dart';

onSubmitRegisterUser() async {
  try {
    await UserRepository().register(
      email: inputState.email.value,
      password: inputState.password.value,
    );
  } catch (e, stack) {
    errorService.notifyError(e: e, stack: stack);
  }
}

class WelcomeBottomSheet extends StatefulWidget {
  const WelcomeBottomSheet({super.key});

  @override
  State<WelcomeBottomSheet> createState() => _WelcomeBottomSheetState();
}

class _WelcomeBottomSheetState extends State<WelcomeBottomSheet> {
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
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      child: Container(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height - 80,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              style.background.greenTransparent.color!,
              style.background.green.color!,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close, color: style.icon.color1.color),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "Bienvenu·e à bord 🔥",
                  style: style.fontsize.lg
                      .merge(style.text.neutral)
                      .merge(style.fontweight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "Tu n'es plus qu'à 60 sec de commencer cette nouvelle aventure",
                    style: style.fontsize.sm.merge(style.text.neutralLight),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 32),
                EmailInputWidget(),
                SizedBox(height: 4),
                PasswordInputWidget(),
                SizedBox(height: 32),
                MainButtonWidget(
                  onClick: () {},
                  text: "créer un compte",
                  iconWidget: Icon(Icons.arrow_forward, size: 20),
                  disabled: false,
                  isLoading: false,
                ),
                SizedBox(height: 40),
                Row(
                  spacing: 8,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: style.border.color.color2.color!,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Ou se connecter via",
                      style: style.fontsize.sm.merge(style.text.neutralLight),
                      textAlign: TextAlign.center,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: style.border.color.color2.color!,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                CustomInkwell(
                  onTap: () {},
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.5),
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: Row(
                        spacing: 8,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            '$imagesPath/google_logo.png',
                            width: 20,
                            height: 20,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            "se connecter avec Google",
                            textAlign: TextAlign.center,
                            style: style.fontsize.sm
                                .merge(style.text.neutral)
                                .merge(style.fontweight.semibold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32),
                Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Tu as déjà un compte ?",
                      style: style.fontsize.sm.merge(style.text.neutralLight),
                    ),
                    Text(
                      "se connecter",
                      style: style.fontsize.sm
                          .merge(style.text.neutralLight)
                          .merge(
                            TextStyle(decoration: TextDecoration.underline),
                          )
                          .merge(style.fontweight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
