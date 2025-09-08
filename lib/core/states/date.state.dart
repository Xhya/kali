import 'package:flutter/material.dart';

final dateState = DateState();

class DateState extends ChangeNotifier {
  final currentDate = ValueNotifier<DateTime>(DateTime.now());

  DateState() {
    currentDate.addListener(notifyListeners);
  }

  @override
  void dispose() {
    currentDate.dispose();
    super.dispose();
  }
}
