import 'package:flutter/material.dart';
import 'package:kalori/client/Screen.service.dart';

var style = Style();

class Style {
  var text = TextColors();
  var background = BackgroundColors();
  var border = CustomBorder();
  var button = ButtonColors();
  var icon = IconsColors();
  var fontsize = FontSizes();
  var fontweight = CustomFontWeight();
  var padding = CustomPadding();
  var gauge = Gauge();
}

Color _blue_100 = const Color(0xFF648DF6);
Color _blue_200 = const Color(0xFF4066F1);
Color _blue_300 = const Color(0xFF3751E7);
Color _blue_400 = const Color(0xFF222BAB);
Color _blue_500 = const Color(0xFF191D52);
Color _yellow = const Color(0xFFDFFE0F);

var _white = Colors.white;
var _black = Colors.black;

class BackgroundColors {
  var neutral = TextStyle(color: _white);
  var reverse_neutral = TextStyle(color: _black);
  var color1 = TextStyle(color: _blue_300);
  var color2 = TextStyle(color: _blue_200);
  var color3 = TextStyle(color: _blue_400);
  var color4 = TextStyle(color: _blue_500);
  var color5 = TextStyle(color: _yellow);
}

class Gauge {
  final main = TextStyle(color: _yellow);
}

class TextColors {
  var neutral = TextStyle(color: _black);
  var reverse_neutral = TextStyle(color: _white);
  var color1 = TextStyle(color: _blue_100);
  var color2 = TextStyle(color: _yellow);
  var color3 = TextStyle(color: _blue_500);
}

class ButtonColors {}

class CustomBorder {
  var color = BorderColors();
  var size = BorderSizes();
  var radius = BorderRadiuses();
}

class BorderColors {
  var color1 = TextStyle(color: _yellow);
  var color2 = TextStyle(color: _blue_200);
}

class BorderSizes {
  var light = 2.0;
  var stroke = 4.0;
}

class BorderRadiuses {
  var sm = 4.0;
  var md = Radius.circular(20);
  var lg = 4.0;
}

class IconsColors {
  var color1 = TextStyle(color: _yellow);
  var color2 = TextStyle(color: _blue_200);
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
  var light = TextStyle(fontWeight: FontWeight.w200);
  var semibold = TextStyle(fontWeight: FontWeight.w500);
  var bold = TextStyle(fontWeight: FontWeight.bold);
}

class CustomPadding {
  double sm = 4;
  double md = 8;
  double lg = 16;
  double xl = 24;
}
