import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/layout/Base.scaffold.dart';
import 'package:kali/client/widgets/CustomCard.widget.dart';
import 'package:kali/client/widgets/CustomInput.dart';
import 'package:kali/client/widgets/TotalCalories.widget.dart';
import 'package:kali/client/widgets/TotalNutriScores.widget.dart';
import 'package:kali/core/utils/macroIcon.utils.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
                child: Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomInput(
                        content: "Mama Kitchen",
                        title: "Ton num d'utilisateur",
                        onChanged: (value) {},
                        suffixIcon: Icon(Icons.ac_unit_outlined),
                      ),
                      SizedBox(height: 32),
                      CustomInput(
                        content:
                            "Je veux changer pour moi, pour me prouver que j'en suis capable.",
                        title: "Ton leitmotiv",
                        onChanged: (value) {},
                        suffixIcon: Icon(Icons.ac_unit_outlined),
                        maxLines: 100,
                      ),
                      SizedBox(height: 32),
                      Text(
                        "Ton plan personnalisé",
                        style: style.text.neutral.merge(style.fontsize.sm),
                      ),
                      SizedBox(height: 4),
                      CustomCard(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          spacing: 12,
                          children: [
                            Text(
                              "⚖️",
                              textAlign: TextAlign.start,
                              style: style.text.green
                                  .merge(style.fontsize.md)
                                  .merge(style.fontweight.bold),
                            ),

                            Expanded(
                              child: Text(
                                "calories",
                                textAlign: TextAlign.start,
                                style: style.text.neutral.merge(
                                  style.fontsize.sm,
                                ),
                              ),
                            ),
                            Text(
                              "1700",
                              textAlign: TextAlign.start,
                              style: style.text.neutral.merge(
                                style.fontsize.sm,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4),
                      CustomCard(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          spacing: 12,
                          children: [
                            Text(
                              proteinIcon,
                              textAlign: TextAlign.start,
                              style: style.text.green
                                  .merge(style.fontsize.md)
                                  .merge(style.fontweight.bold),
                            ),

                            Expanded(
                              child: Text(
                                "protéines",
                                textAlign: TextAlign.start,
                                style: style.text.neutral.merge(
                                  style.fontsize.sm,
                                ),
                              ),
                            ),
                            Text(
                              "140",
                              textAlign: TextAlign.start,
                              style: style.text.neutral.merge(
                                style.fontsize.sm,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4),
                      CustomCard(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          spacing: 12,
                          children: [
                            Text(
                              glucidIcon,
                              textAlign: TextAlign.start,
                              style: style.text.green
                                  .merge(style.fontsize.md)
                                  .merge(style.fontweight.bold),
                            ),

                            Expanded(
                              child: Text(
                                "glucides",
                                textAlign: TextAlign.start,
                                style: style.text.neutral.merge(
                                  style.fontsize.sm,
                                ),
                              ),
                            ),
                            Text(
                              "135",
                              textAlign: TextAlign.start,
                              style: style.text.neutral.merge(
                                style.fontsize.sm,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4),
                      CustomCard(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          spacing: 12,
                          children: [
                            Text(
                              lipidIcon,
                              textAlign: TextAlign.start,
                              style: style.text.green
                                  .merge(style.fontsize.md)
                                  .merge(style.fontweight.bold),
                            ),

                            Expanded(
                              child: Text(
                                "lipides",
                                textAlign: TextAlign.start,
                                style: style.text.neutral.merge(
                                  style.fontsize.sm,
                                ),
                              ),
                            ),
                            Text(
                              "60",
                              textAlign: TextAlign.start,
                              style: style.text.neutral.merge(
                                style.fontsize.sm,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
