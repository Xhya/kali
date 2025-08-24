import 'dart:async';
import 'dart:math';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:kali/core/services/Navigation.service.dart';

launchConfetti() async {
  if (navigationService.context == null) {
    print("Navigation context is null");
  }

  double randomInRange(double min, double max) {
    return min + Random().nextDouble() * (max - min);
  }

  int total = 4;
  int progress = 0;

  Timer.periodic(const Duration(milliseconds: 250), (timer) {
    progress++;

    if (progress >= total) {
      timer.cancel();
      return;
    }

    int count = ((1 - progress / total) * 50).toInt();

    Confetti.launch(
      navigationService.context!,
      options: ConfettiOptions(
        particleCount: count,
        startVelocity: 30,
        spread: 360,
        ticks: 60,
        x: randomInRange(0.1, 0.3),
        y: Random().nextDouble() - 0.2,
      ),
    );
    Confetti.launch(
      navigationService.context!,
      options: ConfettiOptions(
        particleCount: count,
        startVelocity: 30,
        spread: 360,
        ticks: 60,
        x: randomInRange(0.7, 0.9),
        y: Random().nextDouble() - 0.2,
      ),
    );
  });
}
