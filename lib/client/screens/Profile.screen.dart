import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/layout/Base.scaffold.dart';
import 'package:kali/client/widgets/TotalCalories.widget.dart';
import 'package:kali/client/widgets/TotalNutriScores.widget.dart';
import 'package:kali/core/services/Navigation.service.dart';

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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Mama Kitchen",
                            style: style.fontsize.lg
                                .merge(style.text.neutral)
                                .merge(style.fontweight.semibold),
                          ),
                          SizedBox(height: 4),
                          Padding(
                            padding: const EdgeInsets.only(right: 42),
                            child: Text(
                              '"Je veux changer pour moi, pour me prouver que j\'en suis capable."',
                              style: style.fontsize.xs.merge(
                                style.text.neutral,
                              ),
                            ),
                          ),
                          SizedBox(height: 32),
                          TotalCaloriesWidget(),
                          SizedBox(height: 4),
                          TotalNutriScoresWidget(),
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
