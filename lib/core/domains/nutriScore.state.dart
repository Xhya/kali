import 'package:flutter/material.dart';
import 'package:kalori/core/models/NutriScore.model.dart';

var nutriScoreState = NutriScoreState();

class NutriScoreState extends ChangeNotifier {
  NutriScore? _nutriScore;
  NutriScore? get nutriScore => _nutriScore;

  setNutriScore(NutriScore value) {
    _nutriScore = value;
    notifyListeners();
  }
}
