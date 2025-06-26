import 'package:flutter/material.dart';
import 'package:kalori/client/Style.service.dart';
import 'package:kalori/client/widgets/LoaderIcon.widget.dart';
import 'package:kalori/core/models/MealPeriod.enum.dart';
import 'package:kalori/core/models/NutriScore.model.dart';

var quickAddMealState = QuickAddMealState();

class QuickAddMealState extends ChangeNotifier {
  final isLoading = ValueNotifier<bool>(false);
  final userMealText = ValueNotifier<String>("");
  final chosenPeriod = ValueNotifier<MealPeriodEnum?>(null);
  final nutriScore = ValueNotifier<NutriScore?>(null);
  final isExpanded = ValueNotifier<bool>(false);

  bool get canSend =>
      !isLoading.value &&
      userMealText.value.isNotEmpty &&
      chosenPeriod.value != null;

  Widget get suffixIcon =>
      isLoading.value
          ? LoaderIcon()
          : userMealText.value.isNotEmpty && chosenPeriod.value != null
          ? Icon(Icons.send, color: style.icon.color1.color)
          : Icon(Icons.close, color: style.icon.color1.color);

  QuickAddMealState() {
    isLoading.addListener(notifyListeners);
    userMealText.addListener(notifyListeners);
    chosenPeriod.addListener(notifyListeners);
    nutriScore.addListener(notifyListeners);
    isExpanded.addListener(notifyListeners);
  }

  @override
  void dispose() {
    isLoading.dispose();
    userMealText.dispose();
    chosenPeriod.dispose();
    nutriScore.dispose();
    isExpanded.dispose();
    super.dispose();
  }

  reset() {
    isLoading.value = false;
    userMealText.value = "";
    chosenPeriod.value = null;
    nutriScore.value = null;
    isExpanded.value = false;
  }
}
