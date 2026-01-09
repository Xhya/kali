import 'dart:convert';
import 'package:dart_date/dart_date.dart';
import 'package:http/http.dart' as http;
import 'package:kali/core/models/Meal.model.dart';
import 'package:kali/core/models/MealPeriod.enum.dart';
import 'package:kali/core/services/Datetime.extension.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/headers.service.dart';
import 'package:kali/environment.dart';

class MealRepository {
  Future<List<MealModel>> getMeals({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final start = Uri.encodeComponent(startDate.startOfDay.toApiFormat());
    final end = Uri.encodeComponent(endDate.endOfDay.toApiFormat());

    final response = await http.get(
      Uri.parse('$API_URL/meals?start=$start&end=$end'),
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
      "date": date?.toApiFormat(),
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
