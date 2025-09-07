import 'package:flutter/material.dart';
import 'package:kali/core/models/MealPeriod.enum.dart';
import 'package:kali/core/models/NutriScore.model.dart';
import 'package:kali/core/states/Ai.state.dart';

final quickAddMealState = QuickAddMealState();

class QuickAddMealState extends ChangeNotifier {
  final isComputingLoading = ValueNotifier<bool>(false);
  final isAddingLoading = ValueNotifier<bool>(false);
  final computed = ValueNotifier<bool>(false);
  final userMealText = ValueNotifier<String>("");
  final chosenPeriod = ValueNotifier<MealPeriodEnum?>(null);
  final nutriscore = ValueNotifier<NutriScore?>(null);
  final isExpanded = ValueNotifier<bool>(false);
  final date = ValueNotifier<DateTime>(DateTime.now());

  QuickAddMealState() {
    isComputingLoading.addListener(notifyListeners);
    isAddingLoading.addListener(notifyListeners);
    userMealText.addListener(notifyListeners);
    chosenPeriod.addListener(notifyListeners);
    nutriscore.addListener(notifyListeners);
    isExpanded.addListener(notifyListeners);
    date.addListener(notifyListeners);
  }

  @override
  void dispose() {
    isComputingLoading.dispose();
    isAddingLoading.dispose();
    userMealText.dispose();
    chosenPeriod.dispose();
    nutriscore.dispose();
    isExpanded.dispose();
    date.dispose();
    super.dispose();
  }

  void reset() {
    isComputingLoading.value = false;
    userMealText.value = "";
    chosenPeriod.value = null;
    nutriscore.value = null;
    isExpanded.value = false;
    aiState.aiNotUnderstandError.value = false;
  }
}
