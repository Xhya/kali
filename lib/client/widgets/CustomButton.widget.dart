import 'package:flutter/material.dart';
import 'package:kalori/client/Style.service.dart';

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
  });

  final Function onPressed;
  final ButtonTypeEnum buttonType;
  final String? text;
  final bool fullWidth;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    Color? backgroungColor;
    Color? textColor;
    Color? borderColor;
    var borderSize;

    switch (buttonType) {
      case ButtonTypeEnum.filled:
        backgroungColor = style.background.color1.color;
        textColor = style.text.color1.color;
        borderColor = null;
      case ButtonTypeEnum.outline:
        backgroungColor = Colors.transparent;
        textColor = style.text.color1.color;
        borderColor = style.border.color.color1.color;
        borderSize = style.border.size.light;
      case ButtonTypeEnum.tonal:
        backgroungColor = style.background.neutral.color;
        textColor = style.text.color1.color;
        borderColor = null;
    }

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          side: borderColor != null
              ? BorderSide(
                  width: borderSize,
                  color: borderColor,
                )
              : null,
          backgroundColor: backgroungColor,
          shadowColor: Colors.transparent,
        ),
        onPressed: disabled ? null : () async => onPressed(),
        child: Text(
          text ?? "Confirmer",
          style: style.fontsize.md.merge(TextStyle(color: textColor)),
        ),
      ),
    );
  }
}
