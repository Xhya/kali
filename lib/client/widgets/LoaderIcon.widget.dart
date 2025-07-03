import 'package:flutter/material.dart';
import 'package:kalori/client/Style.service.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoaderIcon extends StatelessWidget {
  const LoaderIcon({super.key, this.isLightBackground = false});

  final bool isLightBackground;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: LoadingAnimationWidget.hexagonDots(
        color:
            isLightBackground
                ? style.icon.color2.color!
                : style.icon.color1.color!,
        size: 20,
      ),
    );
  }
}
