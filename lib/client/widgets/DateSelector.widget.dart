import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:kalori/client/Style.service.dart';

class DateSelector extends StatelessWidget {
  const DateSelector({super.key, required this.currentDate});

  final DateTime currentDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 12,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_left),
          color: style.icon.color3.color,
          iconSize: style.fontsize.xl.fontSize,
        ),
        Text(
          currentDate.format("E MMM d y"),
          style: style.text.reverse_neutral
              .merge(style.fontsize.lg)
              .merge(style.fontweight.bold),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_right),
          color: style.icon.color3.color,
          iconSize: style.fontsize.xl.fontSize,
        ),
      ],
    );
  }
}
