import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/core/actions/startForm.actions.dart';
import 'package:kali/core/models/NutriScore.model.dart';
import 'package:kali/core/states/startForm.state.dart';
import 'package:kali/client/widgets/CustomIconButton.widget.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class StartFormTopWidget extends StatefulWidget {
  const StartFormTopWidget({super.key});

  @override
  State<StartFormTopWidget> createState() => _StartFormTopWidgetState();
}

class _StartFormTopWidgetState extends State<StartFormTopWidget> {
  @override
  Widget build(BuildContext context) {
    int currentPage = context.select((StartFormState s) => s.currentPage.value);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        spacing: 4,
        children: [
          CustomIconButtonWidget(
            onPressed: () {
              onClickPrevious();
            },
            icon: Icons.chevron_left_outlined,
            disabled: currentPage == 5,
          ),
          SfLinearGauge(
            minimum: 0,
            maximum: 5,
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
                value: currentPage.toDouble(),
                color: style.background.green.color,
                thickness: 5,
                edgeStyle: LinearEdgeStyle.bothCurve,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
