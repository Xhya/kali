import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kalori/core/models/meal.fixture.dart';
import 'package:kalori/environment.dart';
import 'package:kalori/utils.dart';

class AIRepository {
  Future<String> computeNutriScore(String userText) async {
    if (!isInTestEnv) {
      var body = {
        "contents": [
          {
            "parts": [
              {
                "text":
                    "A partir de ce texte $userText, je veux que le JSON suivant: { 'proteinAmount': {proteinAmount}, 'glucidAmount': {glucidAmount}, 'lipidAmount': {lipidAmount}, 'caloryAmount': {caloryAmount} }. Je veux que la représentation soit le JSON UNIQUEMENT. Et je veux que les données renvoyées soient en grammes, mais je veux que dans le json ce soient des doubles.",
              },
            ],
          },
        ],
      };

      final response = await http.post(
        Uri.parse(googleAIUrl),
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final res = body['candidates'][0]['content']['parts'][0]['text'];
        final nutriScore =
            res.replaceAll('```json', '').replaceAll('```', '').trim();
        return nutriScore;
      } else {
        throw Exception('AI Server not return 200');
      }
    } else {
      return '{"proteinAmount": ${fixtureMeal2.nutriScore!.proteinAmount}, "glucidAmount": ${fixtureMeal2.nutriScore!.glucidAmount}, "lipidAmount": ${fixtureMeal2.nutriScore!.lipidAmount}, "caloryAmount": ${fixtureMeal2.nutriScore!.caloryAmount}}';
    }
  }
}
