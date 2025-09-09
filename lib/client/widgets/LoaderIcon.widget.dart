import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoaderIcon extends StatelessWidget {
  const LoaderIcon({super.key, this.size = 20});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: LoadingAnimationWidget.hexagonDots(
        color: style.icon.color1.color!,
        size: size,
      ),
    );
  }
}
