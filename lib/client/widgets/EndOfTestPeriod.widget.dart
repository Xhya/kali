import 'dart:async';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/CustomButton.widget.dart';
import 'package:kali/client/widgets/CustomCard.widget.dart';
import 'package:kali/core/actions/register.actions.dart';
import 'package:kali/core/states/user.state.dart';

class EndOfTestPeriodWidget extends StatefulWidget {
  const EndOfTestPeriodWidget({super.key});

  @override
  State<EndOfTestPeriodWidget> createState() => _EndOfTestPeriodWidgetState();
}

class _EndOfTestPeriodWidgetState extends State<EndOfTestPeriodWidget> {
  int _seconds =
      userState.user.value?.subscriptionDeadline
          ?.difference(DateTime.now())
          .inSeconds ??
      0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        setState(() {
          _seconds--;
        });
      } else {
        _timer?.cancel();
        // ici tu peux déclencher une action quand le temps est fini
        print("Compteur terminé !");
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(int totalSeconds) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    int hours = totalSeconds ~/ 3600;
    int minutes = (totalSeconds % 3600) ~/ 60;
    int seconds = totalSeconds % 60;

    return "${twoDigits(hours)}h${twoDigits(minutes)}m${twoDigits(seconds)}";
  }

  @override
  Widget build(BuildContext context) {
    bool isInTestPeriod = context.select(
      (UserState s) => s.user.value?.isInTestPeriod() ?? false,
    );

    if (isInTestPeriod) {
      return CustomCard(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        secondary: true,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: style.fontsize.sm.fontSize,
                    color: style.text.neutral.color,
                  ),
                  children: <TextSpan>[
                    TextSpan(text: "Fin de l'essai dans "),
                    TextSpan(
                      text: _formatTime(_seconds),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            ButtonWidget(
              text: "s'abonner",
              onPressed: () {
                onClickSubscribe(context);
              },
              buttonType: ButtonTypeEnum.filled,
            ),
          ],
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
