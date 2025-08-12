import 'package:flutter/material.dart';
import 'package:kali/client/widgets/BottomButton.widget.dart';
import 'package:kali/client/widgets/Login.widget.dart';
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
                children: [
                  BottomButtonWidget(
                    left: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("🚀", style: TextStyle(fontSize: 24)),
                        Text(
                          "Le suivi quotidien est l'outil idéal pour t'aider à atteindre tes objectifs",
                          style: style.fontsize.xs.merge(style.text.neutral),
                          maxLines: 5,
                        ),
                      ],
                    ),
                    buttonText: "Démarrer",
                    onClick: () {
                      navigationService.navigateTo(ScreenEnum.startForm);
                    },
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
