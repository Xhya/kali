import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';

class MainButtonWidget extends StatefulWidget {
  const MainButtonWidget({
    super.key,
    required this.onClick,
    this.text,
    this.iconWidget,
  });

  final VoidCallback onClick;
  final String? text;
  final Widget? iconWidget;

  @override
  State<MainButtonWidget> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButtonWidget> {
  double _bottomPadding = 4;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) async {
        setState(() {
          _bottomPadding = 1;
        });
      },
      onTapUp: (_) async {
        await Future.delayed(const Duration(milliseconds: 100));
        widget.onClick();
        setState(() {
          _bottomPadding = 4;
        });
      },
      child: Container(
        padding: EdgeInsets.only(
          bottom: _bottomPadding,
          left: 1,
          right: 1,
          top: 1,
        ),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
        ),
        child: AnimatedPadding(
          curve: Curves.linear,
          padding: EdgeInsets.only(
            bottom: _bottomPadding,
            left: 1,
            right: 1,
            top: 1,
          ),
          duration: const Duration(milliseconds: 100),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: style.background.green.color,
              border: Border(
                bottom: BorderSide(color: style.background.greenLight.color!),
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                widget.iconWidget!,
                const SizedBox(width: 8),
                Text(
                  widget.text!,
                  style: TextStyle(color: style.text.neutral.color!),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
