import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kali/core/models/Meal.model.dart';
import 'package:kali/core/models/MealPeriod.enum.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/headers.service.dart';
import 'package:kali/environment.dart';

class MealRepository {
  Future<List<MealModel>> getMeals() async {
    final response = await http.get(
      Uri.parse('$API_URL/meals'),
      headers: await headersWithMaybeToken(),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return (body["data"] as List)
          .map((meal) => MealModel.fromJson(meal))
          .toList();
    } else {
      errorService.currentResponseError = response;
      throw Exception();
    }
  }

  Future<MealModel> createMeal({
    MealPeriodEnum? period,
    DateTime? date,
    String? nutriscoreId,
  }) async {
    Map body = {
      "period": period?.label,
      "date":
          date != null
              ? '${date.toUtc().toIso8601String().split('.').first}+00:00'
              : null,
      "nutriscoreId": nutriscoreId,
    };

    final response = await http.post(
      Uri.parse('$API_URL/meals'),
      headers: await headersWithMaybeToken(),
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return MealModel.fromJson(body["data"]);
    } else {
      errorService.currentResponseError = response;
      throw Exception();
    }
  }

  Future<MealModel> updateMeal({
    required String mealId,
    MealPeriodEnum? period,
    DateTime? date,
    String? userText,
    String? nutriscoreId,
  }) async {
    Map body = {
      "period": period?.label,
      "date":
          date != null
              ? '${date.toUtc().toIso8601String().split('.').first}+00:00'
              : null,
      "nutriscoreId": nutriscoreId,
      "text": userText,
    };

    final response = await http.patch(
      Uri.parse('$API_URL/meals/$mealId'),
      headers: await headersWithMaybeToken(),
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return MealModel.fromJson(body["data"]);
    } else {
      errorService.currentResponseError = response;
      throw Exception();
    }
  }

  Future<void> deleteMeal(String mealId) async {
    final response = await http.delete(
      Uri.parse('$API_URL/meals/$mealId'),
      headers: await headersWithMaybeToken(),
    );

    if (response.statusCode == 200) {
      return;
    } else {
      errorService.currentResponseError = response;
      throw Exception();
    }
  }
}
