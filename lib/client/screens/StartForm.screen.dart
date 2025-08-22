import 'package:flutter/material.dart';
import 'package:kali/client/widgets/MainButton.widget.dart';
import 'package:kali/client/widgets/StartFormPage1.widget.dart';
import 'package:kali/client/widgets/StartFormPage2.widget.dart';
import 'package:kali/client/widgets/StartFormPage3.widget.dart';
import 'package:kali/client/widgets/StartFormPage4.widget.dart';
import 'package:kali/client/widgets/StartFormPage5.widget.dart';
import 'package:kali/client/widgets/StartFormPageFinal.widget.dart';
import 'package:kali/client/widgets/StartFormTop.widget.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/states/startForm.state.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/layout/Base.scaffold.dart';
import 'package:kali/core/actions/startForm.actions.dart';

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
    bool isLoading = context.select((StartFormState s) => s.isLoading.value);
    int currentPage = context.select((StartFormState s) => s.currentPage.value);
    PageController controller =
        context.watch<StartFormState>().controller.value;

    return BaseScaffold(
      resizeToAvoidBottomInset: false,
      backButton: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: style.background.greenTransparent.color,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (currentPage < 5) const StartFormTopWidget(),

              Expanded(
                child: IntrinsicHeight(
                  child: PageView.builder(
                    controller: controller,
                    itemCount: 6,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      switch (currentPage) {
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
            ],
          ),
        ),
        floatingActionButton: MainButtonWidget(
          onClick: () {
            navigationService.context = context;
            onClickBottomButton();
          },
          text:
              startFormState.personalNutriScore.value != null
                  ? "c'est parti"
                  : startFormState.isFormDone
                  ? "terminer"
                  : "suivant",
          iconWidget: Icon(Icons.arrow_forward, size: 20),
          disabled: isNextButtonDisabled,
          isLoading: isLoading,
        ),
      ),
    );
  }
}
