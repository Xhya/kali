import 'package:flutter/widgets.dart';
import 'package:kali/client/widgets/Congratulation.widget.dart';
import 'package:kali/client/widgets/FullScreenBottomSheet.widget.dart';
import 'package:kali/core/services/Navigation.service.dart';

Future<void> congratulationNextAction(BuildContext context) async {
  navigationService.context = context;
  await Future.delayed(const Duration(milliseconds: 500));

  navigationService.openBottomSheet(
    widget: FullScreenBottomSheet(
      child: CongratulationWidget(
        child: Text(
          "🎉 Bienvenue dans l'aventure !",
          style: TextStyle(fontSize: 24),
        ),
      ),
    ),
  );

  await Future.delayed(const Duration(seconds: 3));

  navigationService.closeBottomSheet();
}
