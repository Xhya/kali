import 'package:flutter/material.dart';
import 'package:kali/client/widgets/StartFormPage1.widget.dart';
import 'package:kali/client/widgets/StartFormPage2.widget.dart';
import 'package:kali/client/widgets/StartFormTop.widget.dart';
import 'package:kali/core/models/NutriScore.model.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/CustomButton.widget.dart';
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
  startFormState.controller.value.animateToPage(
    startFormState.currentPage.value,
    duration: const Duration(milliseconds: 400),
    curve: Curves.easeInOut,
  );
}

void onClickPrevious() {
  startFormState.currentPage.value = startFormState.currentPage.value - 1;
  startFormState.controller.value.animateToPage(
    startFormState.currentPage.value,
    duration: const Duration(milliseconds: 400),
    curve: Curves.easeInOut,
  );
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
    PageController controller =
        context.watch<StartFormState>().controller.value;

    return BaseScaffold(
      child: Scaffold(
        backgroundColor: style.background.greenTransparent.color,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                children: [
                  StartFormTopWidget(),

                  Expanded(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: PageView.builder(
                          controller: controller,
                          itemCount: 7,
                          onPageChanged: (index) {
                            // TODO
                          },
                          itemBuilder: (_, index) {
                            switch (index) {
                              case 0:
                                return StartFormPage1();
                              case 1:
                                return StartFormPage2();

                              default:
                                return StartFormPage1();
                            }
                          },
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
                  // if (personalNutriScore != null)
                  //   ExpandedWidget(
                  //     child: Wrap(
                  //       spacing: 12,
                  //       runSpacing: 12,
                  //       children: [
                  //         NutriScore2by2Widget(nutriScore: personalNutriScore),
                  //       ],
                  //     ),
                  //   ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: ButtonWidget(
                      text: "Suivant",
                      onPressed: () {
                        onClickNext();
                      },
                      fullWidth: true,
                    ),
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
