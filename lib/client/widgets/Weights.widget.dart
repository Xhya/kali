import 'package:flutter/material.dart';
import 'package:kali/client/widgets/LoaderIcon.widget.dart';
import 'package:kali/core/services/Datetime.extension.dart';
import 'package:kali/core/states/chart.state.dart';
import 'package:kali/core/states/weight.state.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/widgets/CustomCard.widget.dart';
import 'package:kali/client/widgets/CustomInkwell.widget.dart';
import 'package:kali/client/widgets/SlidableItem.widget.dart';
import 'package:kali/core/models/Weight.model.dart';

class WeightsWidget extends StatefulWidget {
  const WeightsWidget({super.key});

  @override
  State<WeightsWidget> createState() => _WeightsWidgetState();
}

class _WeightsWidgetState extends State<WeightsWidget> {
  @override
  Widget build(BuildContext context) {
    final isRefreshLoading = context.select(
      (ChartState s) => s.isRefreshLoading.value,
    );
    final List<WeightModel> weights = context.select(
      (WeightState s) => s.weights.value,
    );

    return isRefreshLoading
        ? Container(
          height: 200,
          alignment: Alignment.center,
          child: LoaderIcon(),
        )
        : ListView.separated(
          shrinkWrap: true,
          itemCount: weights.length,
          separatorBuilder: (context, index) => SizedBox(height: 4),
          itemBuilder: (BuildContext context, int index) {
            final weight = weights[index];
            return CustomInkwell(
              onTap: () {},
              child: CustomCard(
                child: SlidableItem(
                  onRemove: () {},
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(weight.date.formateDate("EE dd MMM")),
                        Text("${weight.value.toString()} kg"),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
  }
}
