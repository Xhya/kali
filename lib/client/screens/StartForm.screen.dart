import 'package:flutter/material.dart';
import 'package:kali/client/widgets/StartFormPage1.widget.dart';
import 'package:kali/client/widgets/StartFormTop.widget.dart';
import 'package:kali/core/models/NutriScore.model.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/CustomButton.widget.dart';
import 'package:kali/client/widgets/Expanded.widget.dart';
import 'package:kali/client/widgets/NutriScore2by2.widget.dart';
import 'package:kali/client/layout/Base.scaffold.dart';
import 'package:kali/core/actions/startForm.actions.dart';
import 'package:kali/core/domains/nutriScore.state.dart';
import 'package:kali/core/services/Translation.service.dart';
import 'package:kali/client/states/startForm.state.dart';

String getSubmitButtonText() {
  if (nutriScoreState.personalNutriScore.value == null) {
    return t('compute');
  } else {
    return t('validate');
  }
}

void onClickNext() {
  startFormState.currentPage.value = startFormState.currentPage.value + 1;
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
    bool isLoading = context.watch<StartFormState>().isLoading.value;

    return BaseScaffold(
      child: Scaffold(
        backgroundColor: style.background.greenTransparent.color,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Column(
                children: [
                  StartFormTopWidget(),

                  Expanded(
                    child: SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: StartFormPage1()),
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
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // ButtonWidget(
                  //   text: "Crash",
                  //   onPressed: () {
                  //     errorService.notifyError(
                  //       e: Exception("Crash button pressed"),
                  //     );
                  //   },
                  //   fullWidth: true,
                  // ),

                  ButtonWidget(
                    text: "Suivant",
                    onPressed: () {
                      onClickNext();
                    },
                    fullWidth: true,
                  ),

                  // ButtonWidget(
                  //   text: getSubmitButtonText(),
                  //   onPressed: () {
                  //     onClickSubmitButton();
                  //   },
                  //   fullWidth: true,
                  //   disabled: isSubmitButtonDisabled,
                  //   isLoading: isLoading,
                  // ),
                  SizedBox(height: 16),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
