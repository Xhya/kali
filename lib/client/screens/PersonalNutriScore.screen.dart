import 'package:flutter/material.dart';
import 'package:kalori/core/models/NutriScore.model.dart';
import 'package:provider/provider.dart';
import 'package:kalori/client/layout/Title.scaffold.dart';
import 'package:kalori/client/widgets/CustomButton.widget.dart';
import 'package:kalori/client/widgets/CustomInput.dart';
import 'package:kalori/core/domains/nutriScore.state.dart';
import 'package:kalori/core/services/Translation.service.dart';

final personalNutriScoreEditionState = PersonalNutriScoreEditionState();

class PersonalNutriScoreEditionState extends ChangeNotifier {
  final editingProteinAmount = ValueNotifier<String>("");
  final editingGlucidAmount = ValueNotifier<String>("");
  final editingLipidAmount = ValueNotifier<String>("");
  final editingCaloryAmount = ValueNotifier<String>("");
  bool get canSave {
    return editingProteinAmount.value.isNotEmpty &&
        editingGlucidAmount.value.isNotEmpty &&
        editingLipidAmount.value.isNotEmpty &&
        editingCaloryAmount.value.isNotEmpty;
  }

  PersonalNutriScoreEditionState() {
    editingProteinAmount.addListener(notifyListeners);
    editingGlucidAmount.addListener(notifyListeners);
    editingLipidAmount.addListener(notifyListeners);
    editingCaloryAmount.addListener(notifyListeners);
  }

  @override
  void dispose() {
    editingProteinAmount.dispose();
    editingGlucidAmount.dispose();
    editingLipidAmount.dispose();
    editingCaloryAmount.dispose();
    super.dispose();
  }
}

onProteinInputChange(String value) {
  personalNutriScoreEditionState.editingProteinAmount.value = value;
}

onGlucidInputChange(String value) {
  personalNutriScoreEditionState.editingGlucidAmount.value = value;
}

onLipidInputChange(String value) {
  personalNutriScoreEditionState.editingLipidAmount.value = value;
}

onCaloryInputChange(String value) {
  personalNutriScoreEditionState.editingCaloryAmount.value = value;
}

class PersonalNutriScoreScreen extends StatefulWidget {
  const PersonalNutriScoreScreen({super.key});

  @override
  State<PersonalNutriScoreScreen> createState() =>
      _PersonalNutriScoreScreenState();
}

class _PersonalNutriScoreScreenState extends State<PersonalNutriScoreScreen> {
  @override
  void initState() {
    personalNutriScoreEditionState.editingProteinAmount.value =
        nutriScoreState.personalNutriScore.value?.proteinAmount.toString() ??
        "";
    personalNutriScoreEditionState.editingGlucidAmount.value =
        nutriScoreState.personalNutriScore.value?.glucidAmount.toString() ?? "";
    personalNutriScoreEditionState.editingLipidAmount.value =
        nutriScoreState.personalNutriScore.value?.lipidAmount.toString() ?? "";
    personalNutriScoreEditionState.editingCaloryAmount.value =
        nutriScoreState.personalNutriScore.value?.caloryAmount.toString() ?? "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NutriScore? personalNutriScore =
        context.watch<NutriScoreState>().personalNutriScore.value;
    bool canSave = context.watch<PersonalNutriScoreEditionState>().canSave;

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
                                content:
                                    personalNutriScore?.proteinAmount
                                        .toString(),
                                onChanged: (value) {
                                  onProteinInputChange(value);
                                },
                                placeholder: t("proteins"),
                                suffixText: "g",
                              ),

                              SizedBox(height: 32),

                              CustomInput(
                                content:
                                    personalNutriScore?.glucidAmount.toString(),
                                onChanged: (value) {
                                  onGlucidInputChange(value);
                                },
                                placeholder: t("proteins"),
                                suffixText: "g",
                              ),

                              SizedBox(height: 32),

                              CustomInput(
                                content:
                                    personalNutriScore?.lipidAmount.toString(),
                                onChanged: (value) {
                                  onLipidInputChange(value);
                                },
                                placeholder: t("lipids"),
                                suffixText: "g",
                              ),

                              SizedBox(height: 32),

                              CustomInput(
                                content:
                                    personalNutriScore?.caloryAmount.toString(),
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
                          disabled: !canSave,
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
