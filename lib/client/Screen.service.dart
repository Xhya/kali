import 'package:flutter/material.dart';

var screenService = ScreenService();

class ScreenService {
  var isSmallScreen = false;

  init(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    isSmallScreen = screenWidth < 400;
  }
}
