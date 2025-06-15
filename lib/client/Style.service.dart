import 'package:flutter/material.dart';
import 'package:kalory/client/Screen.service.dart';

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
}

Color _yellow = const Color(0xFFFCC547);
Color _red = const Color(0xFFEA3B38);
Color _purple = const Color(0xFFBD1689);
Color _blue = const Color(0xFF076CEB);
Color _grey_dark = const Color(0xFF373740);
Color _grey_light = const Color(0xFFE9E2D0);
Color _orange_dark = const Color(0xFFEA3B38);
Color _orange_light = const Color(0xFFF59342);

var _white = Colors.white;
var _black = Colors.black;

class BackgroundColors {
  var color1 = TextStyle(color: _grey_light);
  var onColor1 = TextStyle(color: _white);
  var color2 = TextStyle(color: _blue);

  var neutral = TextStyle(color: _white);
}

class TextColors {
  var color1 = TextStyle(color: _black);
  var color2 = TextStyle(color: _red);
  var color3 = TextStyle(color: _white);
}

class ButtonColors {}

class CustomBorder {
  var color = BorderColors();
  var size = BorderSizes();
  var radius = BorderRadiuses();
}

class BorderColors {
  var color1 = TextStyle(color: _black);
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
  var color2 = TextStyle(color: _grey_light);
  var color3 = TextStyle(color: _black);
  var color4 = TextStyle(color: _blue);
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
