import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoaderIcon extends StatelessWidget {
  const LoaderIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.threeRotatingDots(
      color: Colors.purple,
      size: 30,
    );
  }
}
