import 'package:flutter/material.dart';
import 'package:kali/client/widgets/Chart.widget.dart';
import 'package:kali/client/widgets/ChartCheckboxes.widget.dart';
import 'package:kali/client/Utils/DecimalFormatter.utils.dart';
import 'package:kali/client/Utils/MaxDecimalDigitsCountFormatter.utils.dart';
import 'package:kali/client/widgets/CustomInput.dart';
import 'package:kali/client/widgets/MainButton.widget.dart';
import 'package:kali/client/widgets/Weights.widget.dart';
import 'package:kali/core/domains/chart.service.dart';
import 'package:kali/core/domains/weight.service.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/layout/Base.scaffold.dart';
import 'package:kali/core/states/weight.state.dart';

Future<void> onClickAddWeight() async {
  try {
    weightState.isAddingWeightLoading.value = true;
    await weightService.addWeight();
  } catch (e, stack) {
    errorService.notifyError(e: e, stack: stack);
  } finally {
    weightState.isAddingWeightLoading.value = false;
  }
}

void onClickOpenAddWeight(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Ajouter une pesée"),
        content: IntrinsicHeight(
          child: CustomInput(
            onChanged: (String text) {
              weightState.newWeight.value = double.parse(text);
            },
            inputFormatters: [
              decimalFormatter(),
              MaxDecimalDigitsCountFormatter(
                maxDigitsBeforeDecimal: 3,
                maxDigitsAfterDecimal: 3,
              ),
            ],
            suffixText: "kg",
            textInputAction: TextInputAction.next,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Annuler"),
          ),
          TextButton(
            onPressed: () {
              onClickAddWeight();
              Navigator.of(context).pop();
            },
            child: Text("Ajouter"),
          ),
        ],
      );
    },
  );
}

class EvolutionScreen extends StatefulWidget {
  const EvolutionScreen({super.key});

  @override
  State<EvolutionScreen> createState() => _EvolutionScreenState();
}

class _EvolutionScreenState extends State<EvolutionScreen> {
  @override
  void initState() {
    super.initState();
    chartService.refreshEvolution();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backButton: true,
      child: Scaffold(
        backgroundColor: style.background.greenTransparent.color,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ChartWidget(),

                          ChartCheckboxesWidget(),

                          SizedBox(height: 24),

                          WeightsWidget(),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    right: 24,
                    child: SafeArea(
                      child: MainButtonWidget(
                        onClick: () {
                          onClickOpenAddWeight(context);
                        },
                        text: "+",
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
