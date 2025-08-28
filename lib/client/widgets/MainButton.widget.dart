import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/LoaderIcon.widget.dart';

class MainButtonWidget extends StatefulWidget {
  const MainButtonWidget({
    super.key,
    required this.onClick,
    required this.text,
    this.iconWidget,
    this.disabled = false,
    this.isLoading = false,
  });

  final VoidCallback onClick;
  final String text;
  final Widget? iconWidget;
  final bool disabled;
  final bool isLoading;

  @override
  State<MainButtonWidget> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButtonWidget> {
  double _bottomPadding = 4;

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        widget.disabled ? Colors.grey : style.background.green.color;

    final textColor =
        widget.isLoading
            ? TextStyle(color: Colors.transparent)
            : TextStyle(color: style.text.neutral.color!);

    return GestureDetector(
      onTapDown: (_) async {
        if (!widget.disabled && !widget.isLoading) {
          setState(() {
            _bottomPadding = 1;
          });
        }
      },
      onTapUp: (_) async {
        if (!widget.disabled && !widget.isLoading) {
          HapticFeedback.vibrate();
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
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                if (widget.isLoading) LoaderIcon(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.iconWidget != null) widget.iconWidget!,
                    const SizedBox(width: 8),
                    Text(
                      widget.text,
                      style: style.fontsize.md
                          .merge(style.fontweight.bold)
                          .merge(textColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
