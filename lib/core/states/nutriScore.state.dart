import 'package:flutter/material.dart';
import 'package:kali/core/models/NutriScore.model.dart';

final nutriScoreState = NutriScoreState();

class NutriScoreState extends ChangeNotifier {
  final searchNutriscores = ValueNotifier<List<NutriScore>>([]);

  NutriScoreState() {
    searchNutriscores.addListener(notifyListeners);
  }

  @override
  void dispose() {
    searchNutriscores.dispose();
    super.dispose();
  }
}
