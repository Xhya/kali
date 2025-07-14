import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/CustomButton.widget.dart';
import 'package:kali/core/actions/Goto.actions.dart';
import 'package:kali/core/states/topBanner.state.dart';

class RegisterBannerWidget extends StatefulWidget {
  const RegisterBannerWidget({super.key});

  @override
  State<RegisterBannerWidget> createState() => _RegisterBannerWidgetState();
}

class _RegisterBannerWidgetState extends State<RegisterBannerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: style.background.greenLight.color,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Veuillez vous enregistrer pour sauvegarder vos données.",
                  style: style.text.neutral,
                  maxLines: 2,
                ),
                SizedBox(height: 8),
                ButtonWidget(
                  text: "Se connecter",
                  onPressed: () {
                    goToAuthenticationHome();
                  },
                  fullWidth: false,
                  buttonType: ButtonTypeEnum.tonal,
                ),
              ],
            ),
          ),

          // Expanded(
          //   child: ButtonWidget(
          //     text: t(""),
          //     onPressed: () {
          //     },
          //     buttonType: ButtonTypeEnum.filled,
          //   ),
          // ),
          IconButton(
            onPressed: () async {
              topBannerState.show.value = false;
            },
            icon: Icon(Icons.close, color: style.icon.color3.color),
          ),
        ],
      ),
    );
  }
}
