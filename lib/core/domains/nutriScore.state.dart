import 'package:flutter/material.dart';
import 'package:kalori/core/models/NutriScore.model.dart';

var nutriScoreState = NutriScoreState();

class NutriScoreState extends ChangeNotifier {
  final currentNutriScore = ValueNotifier<NutriScore?>(null);

  NutriScoreState() {
    currentNutriScore.addListener(notifyListeners);
  }

  @override
  void dispose() {
    currentNutriScore.dispose();
    super.dispose();
  }
}
