import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/LoaderIcon.widget.dart';

enum CustomIconFormat { svg, png, flutter }

enum CustomIconType { base, filled }

class CustomIconWidget extends StatelessWidget {
  const CustomIconWidget({
    super.key,
    this.onClick,
    required this.icon,
    this.disabled = false,
    this.isLoading = false,
    this.format = CustomIconFormat.flutter,
    this.type = CustomIconType.base,
  });

  final GestureTapCallback? onClick;
  final Object icon;
  final bool disabled;
  final CustomIconFormat format;
  final bool isLoading;
  final CustomIconType type;

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        type == CustomIconType.base
            ? Colors.transparent
            : disabled
            ? style.iconBackground.color2.color
            : style.iconBackground.color1.color;

    final iconColor =
        type == CustomIconType.base
            ? style.icon.color1.color
            : style.icon.color3.color;

    final iconToDisplay =
        isLoading
            ? LoaderIcon()
            : format == CustomIconFormat.svg
            ? SvgPicture.asset(icon as String, width: 10, height: 20)
            : null;

    return IconButton.filled(
      disabledColor: style.iconBackground.color2.color,
      padding: EdgeInsets.all(0),
      onPressed:
          disabled
              ? null
              : () {
                onClick?.call();
              },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(backgroundColor),
      ),
      icon: iconToDisplay ?? Icon(Icons.abc),
      color: iconColor,
      iconSize: 20,
    );
  }
}
