import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kali/core/domains/nutriScore.repository.dart';
import 'package:kali/core/models/NutriScore.model.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/headers.service.dart';
import 'package:kali/environment.dart';

class UserNutriscoreRepository {
  Future<void> setPersonalNutriScore(String nutriScoreId) async {
    Map body = {"nutriscoreId": nutriScoreId};

    final response = await http.patch(
      Uri.parse('$API_URL/users/nutriscore'),
      headers: await headersWithMaybeToken(),
      body: json.encode(body),
    );

    if (response.statusCode != 200) {
      errorService.currentResponseError = response;
      throw Exception();
    }
  }

  Future<NutriScore?> computePersonalNutriScore(
    PersonalNutriScoreFormData formData,
  ) async {
    Map body = {
      "name": formData.userName,
      "leitmotiv": formData.leitmotiv,
      "birthdate": formData.birthdate,
      "gender": formData.gender,
      "height": formData.height,
      "weight": formData.weight,
      "targetWeight": formData.targetWeight,
      "lifeActivity": formData.lifeActivity,
      "workActivity": formData.workActivity,
    };

    final response = await http.post(
      Uri.parse('$API_URL/users/nutriscore/personal/compute'),
      headers: await headersWithoutToken(),
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return NutriScore.fromJson(body["data"]);
    } else {
      errorService.currentResponseError = response;
      throw Exception();
    }
  }
}
