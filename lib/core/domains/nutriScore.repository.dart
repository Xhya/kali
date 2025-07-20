import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kali/core/domains/nutriScore.data.dart';
import 'package:kali/core/models/NutriScore.model.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/headers.service.dart';
import 'package:kali/environment.dart';

class NutriScoreRepository {
  Future<NutriScore?> getPersonalNutriScore() async {
    return await nutriScoreData.getPersonalNutriScore();
  }

  Future<void> setPersonalNutriScore(NutriScore nutriScore) async {
    await nutriScoreData.setPersonalNutriScore(nutriScore);
  }

  Future<NutriScore> computeNutriScore(String userText) async {
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
