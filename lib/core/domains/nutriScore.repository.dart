import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kali/core/domains/nutriScore.data.dart';
import 'package:kali/core/models/NutriScore.model.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/headers.service.dart';
import 'package:kali/environment.dart';

class PersonalNutriScoreFormData {
  final String userName;
  final String leitmotiv;
  final String birthdate;
  final String gender;
  final String size;
  final String weight;
  final String targetWeight;
  final String speedExpectation;
  final String objective;
  final String lifeRhythm;

  PersonalNutriScoreFormData({
    required this.userName,
    required this.leitmotiv,
    required this.birthdate,
    required this.gender,
    required this.size,
    required this.weight,
    required this.targetWeight,
    required this.speedExpectation,
    required this.objective,
    required this.lifeRhythm,
  });
}

class NutriScoreRepository {
  Future<NutriScore?> getPersonalNutriScore() async {
    return await nutriScoreData.getPersonalNutriScore();
  }

  Future<void> setPersonalNutriScore(NutriScore nutriScore) async {
    await nutriScoreData.setPersonalNutriScore(nutriScore);
  }

  Future<NutriScore?> computePersonalNutriScore(
    PersonalNutriScoreFormData formData,
  ) async {
    Map body = {
      "userName": formData.userName,
      "leitmotiv": formData.leitmotiv,
      "birthdate": formData.birthdate,
      "gender": formData.gender,
      "size": formData.size,
      "weight": formData.weight,
      "targetWeight": formData.targetWeight,
      "speedExpectation": formData.speedExpectation,
      "objective": formData.objective,
      "lifeRhythm": formData.lifeRhythm,
    };

    final response = await http.post(
      Uri.parse('$API_URL/nutriscores/personal/compute'),
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
