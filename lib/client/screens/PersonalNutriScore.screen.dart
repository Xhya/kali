import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/core/domains/nutriScore.service.dart';
import 'package:kali/core/models/NutriScore.model.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/User.service.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/layout/Title.scaffold.dart';
import 'package:kali/client/widgets/CustomButton.widget.dart';
import 'package:kali/client/widgets/CustomInput.dart';
import 'package:kali/core/states/nutriScore.state.dart';
import 'package:kali/core/services/Translation.service.dart';
import 'package:uuid/uuid.dart';

final personalNutriScoreEditionState = PersonalNutriScoreEditionState();

class PersonalNutriScoreEditionState extends ChangeNotifier {
  final isLoading = ValueNotifier<bool>(false);
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
    isLoading.addListener(notifyListeners);
  }

  @override
  void dispose() {
    editingProteinAmount.dispose();
    editingGlucidAmount.dispose();
    editingLipidAmount.dispose();
    editingCaloryAmount.dispose();
    isLoading.dispose();
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

onClickSave() async {
  try {
    personalNutriScoreEditionState.isLoading.value = true;
    final nutriScore = NutriScore(
      id: Uuid().v8(),
      proteinAmount: int.parse(
        personalNutriScoreEditionState.editingProteinAmount.value,
      ),
      glucidAmount: int.parse(
        personalNutriScoreEditionState.editingGlucidAmount.value,
      ),
      lipidAmount: int.parse(
        personalNutriScoreEditionState.editingLipidAmount.value,
      ),
      caloryAmount: int.parse(
        personalNutriScoreEditionState.editingCaloryAmount.value,
      ),
    );

    await userService.setPersonalNutriScore(nutriScore);
    // await refreshPersonalNutriScore();
  } catch (e, stack) {
    errorService.notifyError(e: e, stack: stack);
  } finally {
    personalNutriScoreEditionState.isLoading.value = false;
  }
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
    bool isLoading =
        context.watch<PersonalNutriScoreEditionState>().isLoading.value;

    return TitleScaffold(
      title: "Objectifs",
      child: Scaffold(
        backgroundColor: style.background.greenTransparent.color,
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
                                placeholder: t("glucids"),
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
                          onPressed: () {
                            onClickSave();
                          },
                          fullWidth: true,
                          disabled: !canSave,
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
