import 'package:flutter/material.dart';
import 'package:kalori/core/models/NutriScore.model.dart';

var nutriScoreState = NutriScoreState();

class NutriScoreState extends ChangeNotifier {
  final userMealText = ValueNotifier<String>("");
  final currentNutriScore = ValueNotifier<NutriScore?>(null);

  NutriScoreState() {
    userMealText.addListener(notifyListeners);
    currentNutriScore.addListener(notifyListeners);
  }

  @override
  void dispose() {
    userMealText.dispose();
    currentNutriScore.dispose();
    super.dispose();
  }
}
