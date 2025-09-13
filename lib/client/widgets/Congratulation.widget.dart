import 'package:flutter/material.dart';
import 'package:kali/core/actions/confetti.actions.dart';

class CongratulationWidget extends StatefulWidget {
  const CongratulationWidget({super.key, required this.child});

  final Widget child;

  @override
  State<CongratulationWidget> createState() => _CongratulationWidgetState();
}

class _CongratulationWidgetState extends State<CongratulationWidget> {
  @override
  void initState() {
    super.initState();
    launchConfetti();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [Center(child: widget.child)]);
  }
}
