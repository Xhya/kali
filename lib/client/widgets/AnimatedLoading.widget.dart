import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';

class AnimatedLoadingWidget extends StatefulWidget {
  const AnimatedLoadingWidget({super.key});

  @override
  State<AnimatedLoadingWidget> createState() => _AnimatedLoadingWidgetState();
}

class _AnimatedLoadingWidgetState extends State<AnimatedLoadingWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 72),
        Lottie.asset(
          'assets/animations/test.lottie',
          decoder: customDecoder,
          width: 400,
          height: 300,
          fit: BoxFit.contain,
        ),
        SizedBox(height: 12),
        SizedBox(
          width: 60,
          height: 60,
          child: LoadingAnimationWidget.inkDrop(
            color: style.icon.color1.color!,
            size: 60,
          ),
        ),
      ],
    );
  }
}

Future<LottieComposition?> customDecoder(List<int> bytes) {
  return LottieComposition.decodeZip(
    bytes,
    filePicker: (files) {
      return files.firstWhereOrNull(
        (f) => f.name.startsWith('animations/') && f.name.endsWith('.json'),
      );
    },
  );
}
