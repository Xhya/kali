import 'package:flutter/material.dart';

final dateState = DateState();

class DateState extends ChangeNotifier {
  final currentDate = ValueNotifier<DateTime>(DateTime.now());
  final currentStartDate = ValueNotifier<DateTime?>(null);
  DateTime? get currentEndDate =>
      currentStartDate.value?.add(Duration(days: 6));

  DateState() {
    currentDate.addListener(notifyListeners);
    currentStartDate.addListener(notifyListeners);
  }

  @override
  void dispose() {
    currentDate.dispose();
    currentStartDate.dispose();
    super.dispose();
  }
}
