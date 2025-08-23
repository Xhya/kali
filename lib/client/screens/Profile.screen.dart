import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kali/client/widgets/CustomButton.widget.dart';
import 'package:kali/client/widgets/CustomCard.widget.dart';
import 'package:kali/client/widgets/MacroElementRow.widget.dart';
import 'package:kali/client/widgets/Register.widget.dart';
import 'package:kali/client/widgets/WelcomeBottomSheet.widget.dart';
import 'package:kali/core/actions/checkAppVersion.actions.dart';
import 'package:kali/core/actions/congratulationNextAction.actions.dart';
import 'package:kali/core/models/NutriScore.model.dart';
import 'package:kali/core/services/Authentication.service.dart';
import 'package:kali/core/services/Hardware.service.dart';
import 'package:kali/core/states/configuration.state.dart';
import 'package:kali/core/states/googleSignIn.state.dart';
import 'package:kali/core/utils/macroIcon.utils.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/layout/Base.scaffold.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/states/user.state.dart';

onClickDeconnect() async {
  await hardwareService.deleteSignatureStorage();
  await hardwareService.deleteTokenStorage();
  await authenticationService.initSignature();
  await googleSignInState.signInGoogle.value?.signOut();
  navigationService.navigateTo(ScreenEnum.start);
}

onClickRegister(BuildContext context) async {
  navigationService.context = context;
  navigationService.nextAction = () async {
    await congratulationNextAction(context);
  };
  navigationService.openBottomSheet(
    widget: WelcomeBottomSheet(child: RegisterWidget(title: "Inscris-toi")),
  );
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String currentVersion = context.select(
      (ConfigurationState s) => s.currentVersion.value,
    );
    String currentBuild = context.select(
      (ConfigurationState s) => s.currentBuild.value,
    );
    String lastVersion = context.select(
      (ConfigurationState s) => s.lastVersion.value,
    );

    String? username = context.select((UserState s) => s.user.value?.username);
    String? email = context.select((UserState s) => s.user.value?.email);
    String? leitmotiv = context.select(
      (UserState s) => s.user.value?.leitmotiv,
    );
    NutriScore? personalNutriScore =
        context.watch<UserState>().personalNutriscore;

    return BaseScaffold(
      backButton: true,
      child: Scaffold(
        backgroundColor: style.background.greenTransparent.color,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      right: 10,
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          HapticFeedback.vibrate();
                          navigationService.navigateTo(ScreenEnum.editProfile);
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            style.iconBackground.color1.color,
                          ),
                        ),
                        icon: Icon(Icons.edit_outlined),
                        color: style.icon.color1.color,
                        iconSize: style.fontsize.lg.fontSize,
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (username != null)
                            Text(
                              username,
                              style: style.fontsize.lg
                                  .merge(style.text.neutral)
                                  .merge(style.fontweight.semibold),
                            ),
                          SizedBox(height: 4),
                          if (email != null)
                            Padding(
                              padding: const EdgeInsets.only(right: 42),
                              child: Text(
                                email,
                                style: style.fontsize.xs.merge(
                                  style.text.neutral,
                                ),
                              ),
                            ),
                          SizedBox(height: 4),
                          if (leitmotiv != null)
                            Padding(
                              padding: const EdgeInsets.only(right: 42),
                              child: Text(
                                '"$leitmotiv"',
                                style: style.fontsize.xs.merge(
                                  style.text.neutral,
                                ),
                              ),
                            ),
                          SizedBox(height: 16),
                          CustomCard(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Fin de l'essai dans ...",
                                        style: style.fontsize.sm,
                                      ),
                                      Text(
                                        "Ce serait dommage de s'arrêter là..",
                                        style: style.fontsize.xs,
                                      ),
                                    ],
                                  ),
                                ),
                                ButtonWidget(
                                  text: "s'abonner",
                                  onPressed: () {
                                    onClickRegister(context);
                                  },
                                  buttonType: ButtonTypeEnum.filled,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 32),
                          Text(
                            "Ton plan personnalisé",
                            style: style.fontsize.sm.merge(style.text.neutral),
                          ),
                          SizedBox(height: 8),
                          if (personalNutriScore != null)
                            Column(
                              spacing: 4,
                              children: [
                                MacroElementRow(
                                  icon: caloryIcon,
                                  text:
                                      personalNutriScore.caloryAmount
                                          .toString(),
                                ),
                                MacroElementRow(
                                  icon: proteinIcon,
                                  text:
                                      personalNutriScore.proteinAmount
                                          .toString(),
                                ),
                                MacroElementRow(
                                  icon: glucidIcon,
                                  text:
                                      personalNutriScore.glucidAmount
                                          .toString(),
                                ),
                                MacroElementRow(
                                  icon: lipidIcon,
                                  text:
                                      personalNutriScore.lipidAmount.toString(),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          if (userState.user.value?.emailVerified())
                            ButtonWidget(
                              buttonType: ButtonTypeEnum.outline,
                              text: "Se déconnecter",
                              onPressed: () {
                                onClickDeconnect();
                              },
                            ),
                          SizedBox(height: 12),
                          Text("$currentVersion ($currentBuild)"),
                          SizedBox(height: 2),
                          if (isVersionLower(currentVersion, lastVersion))
                            GestureDetector(
                              onTap: () {
                                // TODO
                              },
                              child: Text(
                                "nouvelle version disponible",
                                style: style.fontsize.sm
                                    .merge(style.text.neutralLight)
                                    .merge(
                                      TextStyle(
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                              ),
                            ),
                          SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
