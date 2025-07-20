import 'package:flutter/material.dart';
import 'package:kali/client/widgets/BottomButton.widget.dart';
import 'package:kali/client/widgets/StartFormPage1.widget.dart';
import 'package:kali/client/widgets/StartFormPage2.widget.dart';
import 'package:kali/client/widgets/StartFormPage3.widget.dart';
import 'package:kali/client/widgets/StartFormPage4.widget.dart';
import 'package:kali/client/widgets/StartFormTop.widget.dart';
import 'package:kali/core/models/NutriScore.model.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/utils/paths.utils.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/CustomButton.widget.dart';
import 'package:kali/client/layout/Base.scaffold.dart';
import 'package:kali/core/states/nutriScore.state.dart';
import 'package:kali/core/states/startForm.state.dart';

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
                  Image.asset('$imagesPath/logo-white-700.png', height: 32),
                  SizedBox(height: 4),
                  Text(
                    "tu racontes, je compte",
                    style: style.text.reverse_neutral.merge(style.fontsize.sm),
                  ),
                ],
              ),
              BottomButtonWidget(
                left: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("🚀", style: TextStyle(fontSize: 24)),
                    Text(
                      "Le suivi quotidien est l'outil idéal pour t'aider à atteindre tes objectifs",
                      style: style.fontsize.xs.merge(style.text.neutral),
                      maxLines: 2,
                    ),
                  ],
                ),
                buttonText: "Démarrer",
                onClick: () {
                  navigationService.navigateTo(ScreenEnum.startForm);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
