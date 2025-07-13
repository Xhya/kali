import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';

class CustomIconWidget extends StatelessWidget {
  const CustomIconWidget({
    super.key,
    required this.onClick,
    required this.icon,
    this.disabled = false,
  });

  final GestureTapCallback onClick;
  final Widget icon;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        disabled
            ? style.iconBackground.color2.color
            : style.iconBackground.color1.color;

    return IconButton.filled(
      disabledColor: style.iconBackground.color2.color,
      padding: EdgeInsets.all(0),
      onPressed:
          disabled
              ? null
              : () {
                onClick();
              },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(backgroundColor),
      ),
      icon: icon,
      color: style.icon.color1.color,
      iconSize: style.fontsize.xl2.fontSize,
    );
  }
}
