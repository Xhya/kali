import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/CustomButton.widget.dart';
import 'package:kali/client/widgets/CustomCard.widget.dart';
import 'package:kali/core/actions/register.actions.dart';

class EndOfTestPeriodWidget extends StatefulWidget {
  const EndOfTestPeriodWidget({super.key});

  @override
  State<EndOfTestPeriodWidget> createState() => _EndOfTestPeriodWidgetState();
}

class _EndOfTestPeriodWidgetState extends State<EndOfTestPeriodWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Fin de l'essai dans ...", style: style.fontsize.sm),
                Text(
                  "Ce serait dommage de s'arrêter là..",
                  style: style.fontsize.xs,
                ),
              ],
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
  }
}
