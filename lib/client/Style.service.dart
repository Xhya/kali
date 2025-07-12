import 'package:flutter/material.dart';
import 'package:kali/client/Screen.service.dart';

final style = Style();

class Style {
  final text = TextColors();
  final background = BackgroundColors();
  final border = CustomBorder();
  final button = ButtonColors();
  final icon = IconsColors();
  final fontsize = FontSizes();
  final fontweight = CustomFontWeight();
  final padding = CustomPadding();
  final gauge = Gauge();
  final period = Period();
}

Color _breakfastColor = _pink;
Color _lunchColor = _orange;
Color _snackColor = _blue_100;
Color _dinerColor = _red;

Color _blue_100 = const Color(0xFF648DF6);
Color _blue_200 = const Color(0xFF4066F1);
Color _blue_300 = const Color(0xFF3751E7);
Color _blue_400 = const Color(0xFF222BAB);
Color _blue_500 = const Color(0xFF191D52);
Color _yellow = const Color(0xFFDFFE0F);
Color _red = const Color(0xFFC72E2E);
Color _orange = const Color(0xFFE8900B);
Color _pink = const Color(0xFFFF63A6);
final _white = Colors.white;
final _black = Colors.black;

class Period {
  final breakfastColor = TextStyle(color: _breakfastColor);
  final lunchColor = TextStyle(color: _lunchColor);
  final snackColor = TextStyle(color: _snackColor);
  final dinerColor = TextStyle(color: _dinerColor);
}

class BackgroundColors {
  final neutral = TextStyle(color: _white);
  final reverse_neutral = TextStyle(color: _black);
  final color1 = TextStyle(color: _blue_300);
  final color2 = TextStyle(color: _blue_200);
  final color3 = TextStyle(color: _blue_400);
  final color4 = TextStyle(color: _blue_500);
  final color5 = TextStyle(color: _yellow);
}

class Gauge {
  final main = TextStyle(color: _yellow);
}

class TextColors {
  final neutral = TextStyle(color: _black);
  final reverse_neutral = TextStyle(color: _white);
  final color1 = TextStyle(color: _blue_100);
  final color2 = TextStyle(color: _yellow);
  final color3 = TextStyle(color: _blue_500);
}

class ButtonColors {}

class CustomBorder {
  final color = BorderColors();
  final size = BorderSizes();
  final radius = BorderRadiuses();
}

class BorderColors {
  final color1 = TextStyle(color: _yellow);
  final color2 = TextStyle(color: _blue_200);
}

class BorderSizes {
  final light = 2.0;
  final stroke = 4.0;
}

class BorderRadiuses {
  final sm = 4.0;
  final md = Radius.circular(20);
  final lg = 4.0;
}

class IconsColors {
  final color1 = TextStyle(color: _yellow);
  final color2 = TextStyle(color: _blue_200);
  final color3 = TextStyle(color: _white);
}

class FontSizes {
  TextStyle get xs =>
      TextStyle(fontSize: !screenService.isSmallScreen ? 14 : 12);
  TextStyle get sm =>
      TextStyle(fontSize: !screenService.isSmallScreen ? 16 : 14);
  TextStyle get md =>
      TextStyle(fontSize: !screenService.isSmallScreen ? 20 : 16);
  TextStyle get lg =>
      TextStyle(fontSize: !screenService.isSmallScreen ? 24 : 20);
  TextStyle get xl =>
      TextStyle(fontSize: !screenService.isSmallScreen ? 30 : 30);
  TextStyle get xl2 =>
      TextStyle(fontSize: !screenService.isSmallScreen ? 30 : 30);
  TextStyle get big =>
      TextStyle(fontSize: !screenService.isSmallScreen ? 50 : 40);
  TextStyle get huge =>
      TextStyle(fontSize: !screenService.isSmallScreen ? 100 : 50);
}

class CustomFontWeight {
  final light = TextStyle(fontWeight: FontWeight.w200);
  final semibold = TextStyle(fontWeight: FontWeight.w500);
  final bold = TextStyle(fontWeight: FontWeight.bold);
}

class CustomPadding {
  double sm = 4;
  double md = 8;
  double lg = 16;
  double xl = 24;
}
