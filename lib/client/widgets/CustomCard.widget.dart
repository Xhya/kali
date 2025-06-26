import 'package:flutter/material.dart';
import 'package:kalori/client/Style.service.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.child,
    this.height,
    this.width,
    this.padding,
  });

  final Widget child;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: padding,
        height: height,
        width: width,
        color: style.background.color2.color,
        child: child,
      ),
    );
  }
}
