import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kali/client/widgets/CustomButton.widget.dart';
import 'package:kali/client/widgets/CustomCard.widget.dart';
import 'package:kali/client/widgets/EndOfTestPeriod.widget.dart';
import 'package:kali/client/widgets/Register.widget.dart';
import 'package:kali/client/widgets/WelcomeBottomSheet.widget.dart';
import 'package:kali/core/actions/checkAppVersion.actions.dart';
import 'package:kali/core/domains/user.repository.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/Hardware.service.dart';
import 'package:kali/core/states/configuration.state.dart';
import 'package:kali/core/states/googleSignIn.state.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/layout/Base.scaffold.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/states/user.state.dart';

Future<void> onClickDeconnect() async {
  try {
    userState.isDeconnectLoading.value = true;
    await hardwareService.deleteSignatureStorage();
    await hardwareService.deleteTokenStorage();
    await googleSignInState.signInGoogle.value?.signOut();
    navigationService.navigateTo(ScreenEnum.start);
  } catch (e, stack) {
    errorService.notifyError(e: e, stack: stack);
  } finally {
    userState.isDeconnectLoading.value = false;
  }
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
    bool isDeconnectLoading = context.select(
      (UserState s) => s.isDeconnectLoading.value,
    );

    return BaseScaffold(
      backButton: true,
      child: Scaffold(
        backgroundColor: style.background.greenTransparent.color,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Container(
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
                          if (email == null)
                            GestureDetector(
                              onTap: () {
                                navigationService.context = context;
                                navigationService.openBottomSheet(
                                  widget: WelcomeBottomSheet(
                                    child: RegisterWidget(
                                      title: "Crée un compte",
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                "créer un compte",
                                style: style.fontsize.sm
                                    .merge(style.text.neutralLight)
                                    .merge(
                                      TextStyle(
                                        decoration: TextDecoration.underline,
                                      ),
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
                          EndOfTestPeriodWidget(),
                          SizedBox(height: 32),

                          CustomCard(
                            onClick: () {
                              navigationService.navigateTo(
                                ScreenEnum.personalNutriscore,
                              );
                            },
                            width: double.infinity,
                            padding: EdgeInsets.all(16),
                            child: Text("Ton plan personnalisé"),
                          ),

                          CustomCard(
                            onClick: () {
                              navigationService.navigateTo(
                                ScreenEnum.evolution,
                              );
                            },
                            width: double.infinity,
                            padding: EdgeInsets.all(16),
                            child: Text("Ton évolution"),
                          ),

                          CustomCard(
                            onClick: () {
                              navigationService.url =
                                  "https://forms.gle/qGX2M9UXuVPJ1Z2x7";
                              navigationService.navigateTo(ScreenEnum.webview);
                            },
                            width: double.infinity,
                            padding: EdgeInsets.all(16),
                            child: Text("Ton feedback"),
                          ),

                          SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ),
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
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        if (userState.user.value?.emailVerifiedAt != null)
                          ButtonWidget(
                            buttonType: ButtonTypeEnum.filled,
                            text: "Se déconnecter",
                            onPressed: () {
                              onClickDeconnect();
                            },
                            isLoading: isDeconnectLoading,
                          ),

                        SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {
                            if (userState.user.value?.email ==
                                "alexia.souvane@gmail.com") {
                              UserRepository().testNotification();
                            }
                          },
                          child: Text("$currentVersion ($currentBuild)"),
                        ),
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
            );
          },
        ),
      ),
    );
  }
}
