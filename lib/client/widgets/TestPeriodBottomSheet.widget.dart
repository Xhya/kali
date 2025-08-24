import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/Benefits.widget.dart';
import 'package:kali/client/widgets/WelcomeBottomSheet.widget.dart';
import 'package:flutter/material.dart';

class TestPeriodBottomSheetWidget extends StatefulWidget {
  const TestPeriodBottomSheetWidget({super.key});

  @override
  State<TestPeriodBottomSheetWidget> createState() =>
      _TestPeriodBottomSheetWidgetState();
}

class _TestPeriodBottomSheetWidgetState
    extends State<TestPeriodBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return WelcomeBottomSheet(
      size: 'small',
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "3 jours d'essai ",
            style: style.text.neutral
                .merge(style.fontsize.lg)
                .merge(style.fontweight.bold),
          ),
          SizedBox(height: 4),
          Text(
            "pour prendre de bonne habitudes ",
            style: style.text.neutralLight.merge(style.fontsize.sm),
          ),
          SizedBox(height: 32),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: BenefitsWidget(),
          ),
        ],
      ),
    );
  }
}
