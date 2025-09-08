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

  PersonalNutriScoreFormData({
    required this.userName,
    required this.leitmotiv,
    required this.birthdate,
    required this.gender,
    required this.height,
    required this.weight,
    required this.targetWeight,
    required this.lifeActivity,
  });
}

class NutriScoreRepository {
  Future<NutriScore?> computeNutriScore({required String userText}) async {
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
