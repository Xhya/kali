import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kali/core/models/NutriScore.model.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/headers.service.dart';
import 'package:kali/environment.dart';

class PersonalNutriScoreFormData {
  final String userName;
  final String leitmotiv;
  final String birthdate;
  final String gender;
  final double height;
  final double weight;
  final double targetWeight;
  final String lifeActivity;
  final String workActivity;

  PersonalNutriScoreFormData({
    required this.userName,
    required this.leitmotiv,
    required this.birthdate,
    required this.gender,
    required this.height,
    required this.weight,
    required this.targetWeight,
    required this.lifeActivity,
    required this.workActivity,
  });
}

class NutriScoreRepository {
  Future<NutriScore?> getNutriscore({required String nutriscoreId}) async {
    final response = await http.get(
      Uri.parse('$API_URL/users/nutriscores/$nutriscoreId'),
      headers: await headersWithMaybeToken(),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return NutriScore.fromJson(body["data"]);
    } else {
      errorService.currentResponseError = response;
      throw Exception();
    }
  }

  Future<List<NutriScore>> searchNutriscore({required String text}) async {
    final formattedText = Uri.encodeComponent(text);

    final response = await http.get(
      Uri.parse('$API_URL/users/nutriscores/search?text=$formattedText'),
      headers: await headersWithMaybeToken(),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return (body["data"] as List)
          .map((it) => NutriScore.fromJson(it))
          .toList();
    } else {
      errorService.currentResponseError = response;
      throw Exception();
    }
  }

  Future<NutriScore?> computeNutriScore({required String userText}) async {
    Map body = {"userText": userText};

    final response = await http.post(
      Uri.parse('$API_URL/users/nutriscores/compute'),
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
