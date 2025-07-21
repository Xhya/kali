import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kali/core/domains/meal.data.dart';
import 'package:kali/core/models/Meal.model.dart';
import 'package:kali/core/models/NutriScore.model.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/headers.service.dart';
import 'package:kali/environment.dart';

class MealRepository {
  Future<List<MealModel>> getMeals() async {
    return await mealData.getMeals();
  }

  Future<void> addMeal(MealModel meal) async {
    await mealData.addMeal(meal);
  }

  Future<NutriScore?> computeNutriScore(String userText) async {
    Map body = {"userText": userText};

    final response = await http.post(
      Uri.parse('$API_URL/nutriscores/compute'),
      headers: await headersWithMaybeToken(),
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return NutriScore.fromJson(body["data"]);
    } else {
      errorService.currentResponseError = response;
      throw Exception();
    }
  }
}
