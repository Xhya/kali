import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kalori/core/models/Meal.model.dart';
import 'package:kalori/core/models/meal.fixture.dart';
import 'package:kalori/environment.dart';

final mealData = MealData();
final mealStoreKey = 'hc_meals';

class MealData {
  final _storage = const FlutterSecureStorage();

  List<MealModel> _meals = [];

  MealData() {
    reset();
  }

  reset() async {
    if (!isInTestEnv) {
      _meals = await getMeals();
    } else {
      _meals = fixtureMeals;
    }
  }

  _store() async {
    if (!isInTestEnv) {
      await _storage.write(key: mealStoreKey, value: jsonEncode(_meals));
    }
  }

  Future<List<MealModel>> getMeals() async {
    if (!isInTestEnv) {
      var str = await _storage.read(key: mealStoreKey);
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
      var str = await _storage.read(key: mealStoreKey);
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
