import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';

class CustomIconButtonWidget extends StatelessWidget {
  const CustomIconButtonWidget({
    super.key,
    required this.onPressed,
    required this.icon,
    this.disabled = false,
  });

  final GestureTapCallback onPressed;
  final IconData icon;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        disabled
            ? style.iconBackground.color2.color
            : style.iconBackground.color1.color;

    return IconButton(
      padding: EdgeInsets.all(0),
      onPressed: () {
        if (!disabled) {
          onPressed();
        }
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(backgroundColor),
      ),
      icon: Icon(icon),
      color: style.icon.color1.color,
      iconSize: style.fontsize.xl2.fontSize,
    );
  }
}
