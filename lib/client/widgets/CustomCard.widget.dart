import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.child,
    this.onClick,
    this.height,
    this.width,
    this.padding,
    this.secondary = false,
    this.withBorder = false,
  });

  final Widget child;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onClick;
  final bool secondary;
  final bool withBorder;

  @override
  Widget build(BuildContext context) {
    final bgColor =
        secondary
            ? style.background.greenLight.color
            : style.background.neutral.color;

    final decoration =
        withBorder
            ? BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(16),
            )
            : null;

    return Container(
      decoration: decoration,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: GestureDetector(
          onTap: onClick,
          child: Container(
            padding: padding,
            height: height,
            width: width,
            color: bgColor,
            child: child,
          ),
        ),
      ),
    );
  }
}
