import 'package:flutter/material.dart';
import 'package:kali/core/models/NutriScore.model.dart';

var nutriScoreState = NutriScoreState();

class NutriScoreState extends ChangeNotifier {
  var currentNutriScore = ValueNotifier<NutriScore?>(null);
  var personalNutriScore = ValueNotifier<NutriScore?>(null);

  NutriScoreState() {
    currentNutriScore.addListener(notifyListeners);
    personalNutriScore.addListener(notifyListeners);
  }

  @override
  void dispose() {
    currentNutriScore.dispose();
    personalNutriScore.dispose();
    super.dispose();
  }
}
