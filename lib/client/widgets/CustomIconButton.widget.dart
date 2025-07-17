import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';

class CustomIconButtonWidget extends StatelessWidget {
  const CustomIconButtonWidget({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  final GestureTapCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.all(0),
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          style.iconBackground.color1.color,
        ),
      ),
      icon: Icon(icon),
      color: style.icon.color1.color,
      iconSize: style.fontsize.xl2.fontSize,
    );
  }
}
