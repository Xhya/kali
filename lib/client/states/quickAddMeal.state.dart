import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/widgets/LoaderIcon.widget.dart';
import 'package:kali/client/widgets/QuickAddMeal.widget.dart';
import 'package:kali/core/models/MealPeriod.enum.dart';
import 'package:kali/core/models/NutriScore.model.dart';
import 'package:kali/core/services/AI.service.dart';

var quickAddMealState = QuickAddMealState();

class QuickAddMealState extends ChangeNotifier {
  final isLoading = ValueNotifier<bool>(false);
  final userMealText = ValueNotifier<String>("");
  final chosenPeriod = ValueNotifier<MealPeriodEnum?>(null);
  final nutriScore = ValueNotifier<NutriScore?>(null);
  final isExpanded = ValueNotifier<bool>(false);

  Widget? get suffixIcon =>
      userMealText.value.isNotEmpty && chosenPeriod.value != null
          ? GestureDetector(
            onTap: () {
              onClickQuickSuffixIcon();
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(color: style.border.color.color2.color!),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child:
                  isLoading.value
                      ? LoaderIcon()
                      : Icon(
                        Icons.calculate,
                        color: style.icon.color2.color,
                        size: 16,
                      ),
            ),
          )
          : null;

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
    aiService.aiNotUnderstandError.value = false;
  }
}
