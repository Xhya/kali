import 'package:flutter/material.dart';
import 'package:kalori/client/Style.service.dart';
import 'package:kalori/client/widgets/CustomButton.widget.dart';
import 'package:kalori/client/widgets/CustomInput.dart';
import 'package:kalori/client/widgets/QuickAddMeal.widget.dart';
import 'package:kalori/client/layout/Base.scaffold.dart';
import 'package:kalori/core/actions/startForm.actions.dart';
import 'package:kalori/core/services/Translation.service.dart';

class StartFormScreen extends StatefulWidget {
  const StartFormScreen({super.key});

  @override
  State<StartFormScreen> createState() => _StartFormScreenState();
}

class _StartFormScreenState extends State<StartFormScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Scaffold(
        backgroundColor: style.background.color1.color,
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
                                onChanged: (String value) {
                                  onInputUpdateUserMealText(value);
                                },
                                suffixText: "cm",
                                placeholder: t("size"),
                              ),
                              SizedBox(height: 32),
                              CustomInput(
                                onChanged: (value) {
                                  onInputUpdateUserMealText(value);
                                },
                                suffixText: "kg",
                                placeholder: t("weight"),
                              ),
                              SizedBox(height: 32),
                              CustomInput(
                                onChanged: (value) {
                                  onInputUpdateUserMealText(value);
                                },
                                suffixText: "ans",
                                placeholder: t("age"),
                              ),
                              SizedBox(height: 32),
                            ],
                          ),
                        ),
                        ButtonWidget(
                          onPressed: () {
                            onComputePersonalNutriScore();
                          },
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
