import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/MainButton.widget.dart';

class BottomButtonWidget extends StatefulWidget {
  const BottomButtonWidget({
    super.key,
    required this.left,
    required this.onClick,
    required this.buttonText,
  });

  final Widget left;
  final Function onClick;
  final String buttonText;

  @override
  State<BottomButtonWidget> createState() => _BottomButtonState();
}

class _BottomButtonState extends State<BottomButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: style.background.grey.color,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: widget.left),
              MainButtonWidget(
                onClick: () {
                  widget.onClick();
                },
                text: widget.buttonText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
