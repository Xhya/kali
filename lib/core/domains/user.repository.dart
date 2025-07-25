import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kali/core/models/NutriScore.model.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/headers.service.dart';
import 'package:kali/environment.dart';

class UserRepository {
  Future<void> register({
    required String email,
    required String password,
  }) async {
    Map body = {"email": email, "password": password};

    final response = await http.post(
      Uri.parse('$API_URL/users/register'),
      headers: await headersWithoutToken(),
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      return;
    } else {
      errorService.currentResponseError = response;
      throw Exception();
    }
  }

  Future<bool> canCompute() async {
    final response = await http.get(
      Uri.parse('$API_URL/users/can-compute'),
      headers: await headersWithMaybeToken(),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return body['data'];
    } else {
      errorService.currentResponseError = response;
      throw Exception();
    }
  }

  Future<void> setPersonalNutriScore(String nutriScoreId) async {
    final response = await http.patch(
      Uri.parse('$API_URL/users/nutriscore'),
      headers: await headersWithMaybeToken(),
      body: json.encode({"nutriScoreId": nutriScoreId}),
    );

    if (response.statusCode != 200) {
      errorService.currentResponseError = response;
      throw Exception();
    }
  }

  Future<NutriScore?> getPersonalNutriScore() async {
    final response = await http.get(
      Uri.parse('$API_URL/users/personal'),
      headers: await headersWithMaybeToken(),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      final data = body["data"];
      return data != null ? NutriScore.fromJson(body["data"]) : null;
    } else {
      errorService.currentResponseError = response;
      throw Exception();
    }
  }
}
