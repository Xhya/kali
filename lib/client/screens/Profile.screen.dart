import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/widgets/CustomButton.widget.dart';
import 'package:kali/client/widgets/CustomCard.widget.dart';
import 'package:kali/client/widgets/EndOfTestPeriod.widget.dart';
import 'package:kali/core/actions/checkAppVersion.actions.dart';
import 'package:kali/core/actions/navigation.actions.dart';
import 'package:kali/core/domains/user.repository.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/Hardware.service.dart';
import 'package:kali/core/services/Translation.service.dart';
import 'package:kali/core/services/User.service.dart';
import 'package:kali/core/states/configuration.state.dart';
import 'package:kali/core/states/googleSignIn.state.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/layout/Base.scaffold.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/states/user.state.dart';

void onClickDeconnect(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: SizedBox(
          width: double.maxFinite,
          child: Text(
            t('confirm_logout'),
            style: style.text.neutral.merge(style.fontsize.md),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(t('cancel')),
          ),
          TextButton(
            onPressed: () {
              onClickConfirmDeconnect();
            },
            child: Text(t('confirm')),
          ),
        ],
      );
    },
  );
}

Future<void> onClickConfirmDeconnect() async {
  try {
    userState.isDeconnectLoading.value = true;
    await userService.deconnectUser();
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

Future<void> onClickEvolution(BuildContext context) async {
  if (userState.user.value?.emailVerifiedAt != null) {
    navigationService.navigateTo(ScreenEnum.evolution);
  } else {
    showRegisterEmailBottomSheet(
      context: context,
      subtitle: "Crée un compte pour utiliser cette fonctionnalité",
    );
  }
}

Future<void> onClickPersonalPlan(BuildContext context) async {
  navigationService.navigateTo(ScreenEnum.personalNutriscore);
}

Future<void> onClickFeedback(BuildContext context) async {
  if (userState.user.value?.emailVerifiedAt != null) {
    final email = userState.user.value?.email;
    if (email != null) {
      navigationService.url =
          "${configurationState.feedbackUrl.value}&entry.807671233=$email";
      navigationService.navigateTo(ScreenEnum.webview);
    }
  } else {
    showRegisterEmailBottomSheet(
      context: context,
      subtitle: "Crée un compte pour utiliser cette fonctionnalité",
    );
  }
}

Future<void> onClickVote(BuildContext context) async {
  if (userState.user.value?.emailVerifiedAt != null) {
    navigationService.navigateTo(ScreenEnum.voteFeature);
  } else {
    showRegisterEmailBottomSheet(
      context: context,
      subtitle: "Crée un compte pour utiliser cette fonctionnalité",
    );
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
                                showRegisterEmailBottomSheet(
                                  context: context,
                                  subtitle: "Veuillez entrer votre email.",
                                );
                              },
                              child: Text(
                                t('create_account'),
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
                              onClickPersonalPlan(context);
                            },
                            width: double.infinity,
                            padding: EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  t('your_personal_plan'),
                                  style: style.text.neutral.merge(
                                    style.fontsize.sm,
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios_outlined),
                              ],
                            ),
                          ),

                          CustomCard(
                            onClick: () {
                              onClickEvolution(context);
                            },
                            width: double.infinity,
                            padding: EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  t('your_evolution'),
                                  style: style.text.neutral.merge(
                                    style.fontsize.sm,
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios_outlined),
                              ],
                            ),
                          ),

                          CustomCard(
                            onClick: () {
                              onClickVote(context);
                            },
                            width: double.infinity,
                            padding: EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    t('vote_for_next_feature'),
                                    style: style.text.neutral.merge(
                                      style.fontsize.sm,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios_outlined),
                              ],
                            ),
                          ),

                          if (configurationState.feedbackUrl.value.isNotEmpty)
                            CustomCard(
                              onClick: () {
                                onClickFeedback(context);
                              },
                              width: double.infinity,
                              padding: EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    t('your_feedback'),
                                    style: style.text.neutral.merge(
                                      style.fontsize.sm,
                                    ),
                                  ),
                                  Icon(Icons.arrow_forward_ios_outlined),
                                ],
                              ),
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
                              onClickDeconnect(context);
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
                              t('new_available_version'),
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
