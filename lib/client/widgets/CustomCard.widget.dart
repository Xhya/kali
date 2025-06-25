import 'package:flutter/material.dart';
import 'package:kalori/client/Style.service.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        color: style.background.color2.color,
        child: child,
      ),
    );
  }
}
