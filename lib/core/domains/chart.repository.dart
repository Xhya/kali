import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kali/core/models/Evolution.model.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/headers.service.dart';
import 'package:kali/environment.dart';

class ChartRepository {
  Future<EvolutionModel> getEvolution() async {
    final response = await http.get(
      Uri.parse('$API_URL/users/charts/evolution'),
      headers: await headersWithToken(),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return EvolutionModel.fromJson(body["data"]);
    } else {
      errorService.currentResponseError = response;
      throw Exception();
    }
  }
}
