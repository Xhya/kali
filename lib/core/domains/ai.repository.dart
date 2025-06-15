import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kalory/environment.dart';
import 'package:kalory/utils.dart';

class AIRepository {
  Future<void> getTodoCategory(String userText) async {
    var body = {
      "contents": [
        {
          "parts": [
            {
              "text":
                  "Ce mot est un nom d'item d'une todolist de course: . Définis la categories en un seul mot parmi ",
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
      var category = body['candidates'][0]['content']['parts'][0]['text'];
      print(category);
      // return ProductCategoryEnum.fromText(category.toLowerCase().trim());
    } else {
      throw Exception('AI Server Error');
    }
  }
}
