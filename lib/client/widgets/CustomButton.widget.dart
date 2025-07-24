import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/CustomInkwell.widget.dart';
import 'package:kali/client/widgets/LoaderIcon.widget.dart';
import 'package:kali/core/services/connexion.service.dart';

enum ButtonTypeEnum { filled, outline, tonal }

enum ButtonSizeEnum { S, M, L }

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.onPressed,
    this.buttonType = ButtonTypeEnum.filled,
    this.text,
    this.fullWidth = false,
    this.disabled = false,
    this.isLoading = false,
    this.needConnection = false,
  });

  final GestureTapCallback onPressed;
  final ButtonTypeEnum buttonType;
  final String? text;
  final bool fullWidth;
  final bool disabled;
  final bool isLoading;
  final bool needConnection;

  @override
  Widget build(BuildContext context) {
    Color? backgroungColor;
    Color? textColor;
    Color? borderColor;
    var borderSize;

    var isButtonDisabled = disabled;
    var currentText = text ?? "Confirmer";

    if (!disabled && needConnection) {
      final hasInternetConnexion =
          context.watch<ConnexionService>().hasInternetConnexion.value;
      isButtonDisabled = !hasInternetConnexion;

      if (!hasInternetConnexion) {
        currentText = "Nécessite une connexion";
      }
    }

    switch (buttonType) {
      case ButtonTypeEnum.filled:
        backgroungColor =
            isButtonDisabled ? Colors.grey : style.background.greenDark.color;
        textColor = style.text.green.color;
        borderColor = null;
      case ButtonTypeEnum.outline:
        backgroungColor = Colors.transparent;
        textColor = style.text.neutral.color;
        borderColor = style.border.color.color1.color;
        borderSize = style.border.size.light;
      case ButtonTypeEnum.tonal:
        backgroungColor = style.background.neutral.color;
        textColor = style.text.neutral.color;
        borderColor = null;
    }

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: CustomInkwell(
        onTap: isButtonDisabled ? () {} : onPressed,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(16)),

          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: backgroungColor,
              border:
                  borderColor != null
                      ? Border.all(width: borderSize, color: borderColor)
                      : null,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child:
                isLoading
                    ? LoaderIcon()
                    : Text(
                      currentText,
                      textAlign: TextAlign.center,
                      style: style.fontsize.md
                          .merge(style.fontweight.semibold)
                          .merge(TextStyle(color: textColor)),
                    ),
          ),
        ),
      ),
    );
  }
}
