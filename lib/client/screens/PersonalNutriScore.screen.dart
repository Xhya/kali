import 'package:flutter/material.dart';
import 'package:kalori/client/layout/Title.scaffold.dart';
import 'package:kalori/client/widgets/CustomButton.widget.dart';
import 'package:kalori/client/widgets/CustomInput.dart';
import 'package:kalori/core/services/Translation.service.dart';

onProteinInputChange(String value) {}

onGlucidInputChange(String value) {}

onLipidInputChange(String value) {}

onCaloryInputChange(String value) {}

class PersonalNutriScoreScreen extends StatefulWidget {
  const PersonalNutriScoreScreen({super.key});

  @override
  State<PersonalNutriScoreScreen> createState() =>
      _PersonalNutriScoreScreenState();
}

class _PersonalNutriScoreScreenState extends State<PersonalNutriScoreScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TitleScaffold(
      title: "Objectifs",
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              CustomInput(
                                onChanged: (value) {
                                  onProteinInputChange(value);
                                },
                                placeholder: t("proteins"),
                                suffixText: "g",
                              ),
                              
                              SizedBox(height: 32),

                              CustomInput(
                                onChanged: (value) {
                                  onGlucidInputChange(value);
                                },
                                placeholder: t("proteins"),
                                suffixText: "g",
                              ),

                              SizedBox(height: 32),

                              CustomInput(
                                onChanged: (value) {
                                  onLipidInputChange(value);
                                },
                                placeholder: t("lipids"),
                                suffixText: "g",
                              ),

                              SizedBox(height: 32),

                              CustomInput(
                                onChanged: (value) {
                                  onCaloryInputChange(value);
                                },
                                placeholder: t("calories"),
                                suffixText: "g",
                              ),

                              SizedBox(height: 32),
                            ],
                          ),
                        ),
                        ButtonWidget(
                          text: "Sauvegarder",
                          buttonType: ButtonTypeEnum.filled,
                          onPressed: () {},
                          fullWidth: true,
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
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
