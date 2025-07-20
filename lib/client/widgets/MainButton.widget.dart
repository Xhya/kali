import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';

class MainButtonWidget extends StatefulWidget {
  const MainButtonWidget({
    super.key,
    required this.onClick,
    this.text,
    this.iconWidget,
    this.disabled = false,
  });

  final VoidCallback onClick;
  final String? text;
  final Widget? iconWidget;
  final bool disabled;

  @override
  State<MainButtonWidget> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButtonWidget> {
  double _bottomPadding = 4;

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        widget.disabled ? Colors.grey : style.background.green.color;

    return GestureDetector(
      onTapDown: (_) async {
        if (!widget.disabled) {
          setState(() {
            _bottomPadding = 1;
          });
        }
      },
      onTapUp: (_) async {
        if (!widget.disabled) {
          await Future.delayed(const Duration(milliseconds: 100));
          widget.onClick();
          setState(() {
            _bottomPadding = 4;
          });
        }
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
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.iconWidget != null) widget.iconWidget!,
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
