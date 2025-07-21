import 'package:flutter/material.dart';
import 'package:kali/client/widgets/MainButton.widget.dart';
import 'package:kali/client/widgets/StartFormPage1.widget.dart';
import 'package:kali/client/widgets/StartFormPage2.widget.dart';
import 'package:kali/client/widgets/StartFormPage3.widget.dart';
import 'package:kali/client/widgets/StartFormPage4.widget.dart';
import 'package:kali/client/widgets/StartFormPage5.widget.dart';
import 'package:kali/client/widgets/StartFormPageFinal.widget.dart';
import 'package:kali/client/widgets/StartFormTop.widget.dart';
import 'package:kali/core/states/nutriScore.state.dart';
import 'package:kali/core/states/startForm.state.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/layout/Base.scaffold.dart';
import 'package:kali/core/actions/startForm.actions.dart';

void onClickBottomButton() async {
  if (nutriScoreState.personalNutriScore.value != null) {
    await validateNutriScore();
  } else if (startFormState.isFormDone) {
    await computePersonalNutriScore();
    onClickNext();
  } else {
    onClickNext();
  }
}

void onClickNext() {
  if (startFormState.currentPage.value < 5) {
    startFormState.currentPage.value = startFormState.currentPage.value + 1;
    startFormState.controller.value.animateToPage(
      startFormState.currentPage.value,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}

void onClickPrevious() {
  if (startFormState.currentPage.value > 1) {
    startFormState.currentPage.value = startFormState.currentPage.value - 1;
    startFormState.controller.value.animateToPage(
      startFormState.currentPage.value,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}

Future<void> computePersonalNutriScore() async {
  startFormState.isLoading.value = true;
  await onComputePersonalNutriScore();
  startFormState.isLoading.value = false;
}

Future<void> validateNutriScore() async {
  startFormState.isLoading.value = true;
  await onValidatePersonalNutriScore();
  startFormState.isLoading.value = false;
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
    bool isNextButtonDisabled =
        context.watch<StartFormState>().isNextButtonDisabled;
    bool isLoading = context.watch<StartFormState>().isLoading.value;
    context.watch<StartFormState>().currentPage.value;
    PageController controller =
        context.watch<StartFormState>().controller.value;

    return BaseScaffold(
      child: Scaffold(
        backgroundColor: style.background.greenTransparent.color,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StartFormTopWidget(),

              Expanded(
                child: IntrinsicHeight(
                  child: PageView.builder(
                    controller: controller,
                    itemCount: 6,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      switch (index) {
                        case 0:
                          return StartFormPage1();
                        case 1:
                          return StartFormPage2();
                        case 2:
                          return StartFormPage3();
                        case 3:
                          return StartFormPage4();
                        case 4:
                          return StartFormPage5();
                        case 5:
                          return StartFormPageFinal();
                        default:
                          return StartFormPage1();
                      }
                    },
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
            ],
          ),
        ),
        floatingActionButton: MainButtonWidget(
          onClick: () {
            onClickBottomButton();
          },
          text: startFormState.isFormDone ? "terminer" : "suivant",
          iconWidget: Icon(Icons.arrow_forward, size: 20),
          disabled: isNextButtonDisabled,
        ),
      ),
    );
  }
}
