import 'package:flutter/material.dart';
import 'package:kalori/client/Style.service.dart';
import 'package:kalori/client/widgets/CustomInkwell.widget.dart';
import 'package:kalori/client/widgets/LoaderIcon.widget.dart';

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
  });

  final GestureTapCallback onPressed;
  final ButtonTypeEnum buttonType;
  final String? text;
  final bool fullWidth;
  final bool disabled;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    Color? backgroungColor;
    Color? textColor;
    Color? borderColor;
    var borderSize;

    switch (buttonType) {
      case ButtonTypeEnum.filled:
        backgroungColor = style.background.color5.color;
        textColor = style.text.color3.color;
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

    return Container(
      alignment: Alignment.center,
      width: fullWidth ? double.infinity : null,
      height: 80,
      child: CustomInkwell(
        onTap: disabled ? () {} : onPressed,
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
                      text ?? "Confirmer",
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
