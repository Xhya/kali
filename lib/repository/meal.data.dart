import 'dart:convert';
import 'package:kali/repository/localStorage.repository.dart';
import 'package:kali/core/models/Meal.model.dart';
import 'package:kali/core/models/meal.fixture.dart';
import 'package:kali/core/utils/storageKeys.utils.dart';
import 'package:kali/environment.dart';

final mealData = MealData();

class MealData {
  List<MealModel> _meals = [];

  MealData() {
    reset();
  }

  Future<void> reset() async {
    if (!isInTestEnv) {
      _meals = await getMeals();
    } else {
      _meals = fixtureMeals;
    }
  }

  Future<void> _store() async {
    if (!isInTestEnv) {
      await localStorageRepository.write(mealStoreKey, jsonEncode(_meals));
    }
  }

  Future<List<MealModel>> getMeals() async {
    if (!isInTestEnv) {
      var str = await localStorageRepository.read(mealStoreKey);
      if (str == null) {
        return _meals;
      }
      final json = jsonDecode(str);
      return (json as List).map((e) => MealModel.fromJson(e)).toList();
    } else {
      return _meals;
    }
  }

  Future<void> addMeal(MealModel meal) async {
    if (!isInTestEnv) {
      var str = await localStorageRepository.read(mealStoreKey);
      str ??= "[]";
      var json = jsonDecode(str);
      final meals = json.map((e) => MealModel.fromJson(e)).toList();
      _meals = [...meals, meal];
      await _store();
      return;
    } else {
      _meals = [..._meals, meal];
      return;
    }
  }
}
