import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kalori/core/models/NutriScore.model.dart';
import 'package:kalori/core/utils/computeMealPeriod.utils.dart';
import 'package:kalori/environment.dart';
import 'package:kalori/utils.dart';

class AIRepository {
  Future<NutriScore> computeNutriScore(String userText) async {
    var body = {
      "contents": [
        {
          "parts": [
            {
              "text":
                  "A partir de ce texte $userText, je veux que le JSON suivant: { 'proteinAmount': {proteinAmount}, 'glucidAmount': {glucidAmount}, 'lipidAmount': {lipidAmount} }. Je veux que la représentation soit le JSON UNIQUEMENT. Et je veux que les données renvoyées soient en grammes, mais je veux que dans le json ce soient des doubles.",
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
      final nutriScoreJson = jsonDecode(nutriScore);

      return NutriScore(
        id: "0",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        mealDescription: "100g Pizza",
        period: computeMealPeriod(DateTime.now()),
        proteinAmount: nutriScoreJson["proteinAmount"],
        lipidAmount: nutriScoreJson["lipidAmount"],
        glucidAmount: nutriScoreJson["glucidAmount"],
      );
    } else {
      throw Exception('AI Server Error');
    }
  }
}
