import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';

final linearGradient = LinearGradient(
  colors: [
    style.background.greenTransparent.color!,
    style.background.green.color!,
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
