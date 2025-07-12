import 'package:flutter/material.dart';
import 'package:kali/core/services/Translation.service.dart';
import 'package:kali/core/services/connexion.service.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';
class MaybeConnexionMissingWidget extends StatefulWidget {
  const MaybeConnexionMissingWidget({super.key});

  @override
  State<MaybeConnexionMissingWidget> createState() => _MealPeriodTagWidgetState();
}

class _MealPeriodTagWidgetState extends State<MaybeConnexionMissingWidget> {
  @override
  Widget build(BuildContext context) {
    bool hasInternetConnexion =
        context.watch<ConnexionService>().hasInternetConnexion.value;

    if (!hasInternetConnexion) {
      return Container(
        height: 25,
        width: double.infinity,
        alignment: Alignment.center,
        color: Colors.amber,
        child: Text(
          t('no_internet_connexion'),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: style.fontsize.sm.fontSize,
            color: style.text.neutral.color,
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
