import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';

final inputDecoration = InputDecoration(
  border: InputBorder.none,
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: style.border.color.color1.color!),
    borderRadius: BorderRadius.circular(16),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent),
    borderRadius: BorderRadius.circular(16),
  ),
  contentPadding: EdgeInsets.symmetric(
    //vertical: 20,
    horizontal: 16,
  ),
  labelStyle: style.text.greenDark,
  suffixStyle: style.text.greenDark,
);
