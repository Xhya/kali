import 'package:flutter/material.dart';

class CustomInkwell extends StatelessWidget {
  const CustomInkwell({super.key, required this.child, required this.onTap});

  final Widget child;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: child,
      ),
    );
  }
}
