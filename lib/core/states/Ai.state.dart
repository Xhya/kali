import 'package:flutter/material.dart';

var aiState = AIState();

class AIState extends ChangeNotifier {
  final aiNotUnderstandError = ValueNotifier<bool>(false);

  AIState() {
    aiNotUnderstandError.addListener(notifyListeners);
  }

  @override
  void dispose() {
    aiNotUnderstandError.dispose();
    super.dispose();
  }
}
