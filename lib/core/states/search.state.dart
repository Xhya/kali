import 'package:flutter/material.dart';
import 'package:kali/core/models/Meal.model.dart';

final searchState = SearchState();

class SearchState extends ChangeNotifier {
  final searchText = ValueNotifier<String>("");
  final searchMeals = ValueNotifier<List<MealModel>>([]);

  SearchState() {
    searchText.addListener(notifyListeners);
    searchMeals.addListener(notifyListeners);
  }

  @override
  void dispose() {
    searchText.dispose();
    searchMeals.dispose();
    super.dispose();
  }
}
