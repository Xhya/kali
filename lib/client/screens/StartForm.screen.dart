import 'package:flutter/material.dart';
import 'package:kali/client/widgets/CustomIconButton.widget.dart';
import 'package:kali/client/widgets/StartFormPage1.widget.dart';
import 'package:kali/core/models/NutriScore.model.dart';
import 'package:kali/core/services/Error.service.dart';
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
import 'package:syncfusion_flutter_gauges/gauges.dart';

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
                  Row(
                    spacing: 4,
                    children: [
                      CustomIconButtonWidget(
                        onPressed: () {},
                        icon: Icons.chevron_left_outlined,
                      ),
                      SfLinearGauge(
                        minimum: 0,
                        maximum: 7,
                        showLabels: false,
                        showTicks: false,
                        orientation: LinearGaugeOrientation.horizontal,
                        majorTickStyle: LinearTickStyle(length: 20),
                        axisTrackStyle: LinearAxisTrackStyle(
                          color: style.background.greenDark.color,
                          edgeStyle: LinearEdgeStyle.bothCurve,
                          thickness: 5,
                        ),
                        barPointers: [
                          LinearBarPointer(
                            value: 1,
                            color: style.background.green.color,
                            thickness: 5,
                            edgeStyle: LinearEdgeStyle.bothCurve,
                          ),
                        ],
                      ),
                    ],
                  ),

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
                                Expanded(
                                  child: StartFormPage1()
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
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ButtonWidget(
                    text: "Crash",
                    onPressed: () {
                      errorService.notifyError(
                        e: Exception("Crash button pressed"),
                      );
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
            );
          },
        ),
      ),
    );
  }
}
