import 'package:flutter/material.dart';
import 'package:kalori/core/models/NutriScore.model.dart';
import 'package:kalori/core/services/Error.service.dart';
import 'package:kalori/core/utils/formatters.utils.dart';
import 'package:provider/provider.dart';
import 'package:kalori/client/Style.service.dart';
import 'package:kalori/client/widgets/CustomButton.widget.dart';
import 'package:kalori/client/widgets/CustomInput.dart';
import 'package:kalori/client/widgets/Expanded.widget.dart';
import 'package:kalori/client/widgets/NutriScore2by2.widget.dart';
import 'package:kalori/client/layout/Base.scaffold.dart';
import 'package:kalori/core/actions/startForm.actions.dart';
import 'package:kalori/core/domains/nutriScore.state.dart';
import 'package:kalori/core/services/Translation.service.dart';
import 'package:kalori/client/states/startForm.state.dart';

onUpdateSize(String value) {
  startFormState.size.value = value;
}

onUpdateWeight(String value) {
  startFormState.weight.value = value;
}

onUpdateAge(String value) {
  startFormState.age.value = value;
}

String getSubmitButtonText() {
  if (nutriScoreState.personalNutriScore.value == null) {
    return t('compute');
  } else {
    return t('validate');
  }
}

Future<void> onClickSubmitButton() async {
  if (nutriScoreState.personalNutriScore.value == null) {
    startFormState.isLoading.value = true;
    await onComputePersonalNutriScore();
    startFormState.isLoading.value = false;
  } else {
    startFormState.isLoading.value = true;
    await onValidatePersonalNutriScore();
    startFormState.isLoading.value = false;
  }
}

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
    NutriScore? personalNutriScore =
        context.watch<NutriScoreState>().personalNutriScore.value;
    bool isSubmitButtonDisabled =
        context.watch<StartFormState>().isSubmitButtonDisabled;
    String age = context.watch<StartFormState>().age.value;
    String weight = context.watch<StartFormState>().weight.value;
    String size = context.watch<StartFormState>().size.value;
    bool isLoading = context.watch<StartFormState>().isLoading.value;

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
                                content: size,
                                onChanged: (String value) {
                                  onUpdateAge(value);
                                },
                                suffixText: "cm",
                                placeholder: t("size"),
                                inputFormatters: [onlyNumbersFormatter()],
                              ),
                              SizedBox(height: 32),
                              CustomInput(
                                content: weight,
                                onChanged: (value) {
                                  onUpdateWeight(value);
                                },
                                suffixText: "kg",
                                placeholder: t("weight"),
                                inputFormatters: [onlyNumbersFormatter()],
                              ),
                              SizedBox(height: 32),
                              CustomInput(
                                content: age,
                                onChanged: (value) {
                                  onUpdateSize(value);
                                },
                                suffixText: "ans",
                                placeholder: t("age"),
                                inputFormatters: [onlyNumbersFormatter()],
                              ),
                              SizedBox(height: 32),
                            ],
                          ),
                        ),
                        if (personalNutriScore != null)
                          ExpandedWidget(
                            child: Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                NutriScore2by2Widget(
                                  nutriScore: personalNutriScore,
                                ),
                              ],
                            ),
                          ),
                        ButtonWidget(
                          text: "Crash",
                          onPressed: () {
                            errorService.notifyError(e: Exception("Crash button pressed"));
                          },
                          fullWidth: true,
                        ),

                        ButtonWidget(
                          text: getSubmitButtonText(),
                          onPressed: () {
                            onClickSubmitButton();
                          },
                          fullWidth: true,
                          disabled: isSubmitButtonDisabled,
                          isLoading: isLoading,
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
