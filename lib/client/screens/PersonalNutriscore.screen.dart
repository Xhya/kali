import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kali/client/widgets/MacroElementRow.widget.dart';
import 'package:kali/core/models/NutriScore.model.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/utils/macroIcon.utils.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/layout/Base.scaffold.dart';
import 'package:kali/core/states/user.state.dart';

class PersonalNutriscoreScreen extends StatefulWidget {
  const PersonalNutriscoreScreen({super.key});

  @override
  State<PersonalNutriscoreScreen> createState() =>
      _PersonalNutriscoreScreenState();
}

class _PersonalNutriscoreScreenState extends State<PersonalNutriscoreScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NutriScore? personalNutriScore =
        context.watch<UserState>().personalNutriscore;

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
                                  text: "calories",
                                  icon: caloryIcon,
                                  amount:
                                      personalNutriScore.caloryAmount
                                          .toString(),
                                ),
                                MacroElementRow(
                                  text: "protéines",

                                  icon: proteinIcon,
                                  amount:
                                      personalNutriScore.proteinAmount
                                          .toString(),
                                ),
                                MacroElementRow(
                                  text: "glucides",
                                  icon: glucidIcon,
                                  amount:
                                      personalNutriScore.glucidAmount
                                          .toString(),
                                ),
                                MacroElementRow(
                                  text: "lipides",
                                  icon: lipidIcon,
                                  amount:
                                      personalNutriScore.lipidAmount.toString(),
                                ),
                              ],
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
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
