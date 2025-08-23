import 'package:flutter/material.dart';
import 'package:kali/client/widgets/Login.widget.dart';
import 'package:kali/client/widgets/MainButton.widget.dart';
import 'package:kali/client/widgets/WelcomeBottomSheet.widget.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/utils/paths.utils.dart';
import 'package:kali/client/Style.service.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartFormScreenState();
}

class _StartFormScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("$imagesPath/header-photo.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 16),
                  Image.asset('$imagesPath/logo-white-700.png', height: 32),
                  SizedBox(height: 4),
                  Text(
                    "tu racontes, je compte",
                    style: style.text.reverse_neutral.merge(style.fontsize.sm),
                  ),
                ],
              ),
              Column(
                spacing: 16,
                children: [
                  IntrinsicHeight(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 20,
                        ),
                        decoration: BoxDecoration(
                          color: style.background.grey.color?.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          spacing: 12,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MainButtonWidget(
                              onClick: () {
                                navigationService.navigateTo(
                                  ScreenEnum.startForm,
                                );
                              },
                              text: "Démarrer",
                            ),
                            Text(
                              "Il n'est pas nécessaire d'aller vite, le tout est de ne pas s'arrêter.",
                              textAlign: TextAlign.center,
                              style: style.fontsize.xs.merge(
                                style.text.reverse_neutral,
                              ),
                              maxLines: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      navigationService.context = context;
                      navigationService.openBottomSheet(
                        widget: WelcomeBottomSheet(child: LoginWidget()),
                      );
                    },
                    child: Text(
                      "j'ai déjà un compte",
                      style: style.fontsize.sm
                          .merge(style.text.reverse_neutral)
                          .merge(
                            TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: style.text.reverse_neutral.color,
                            ),
                          ),
                    ),
                  ),
                  SizedBox(height: 12),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
