import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kali/core/models/ChartData.model.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/headers.service.dart';
import 'package:kali/environment.dart';

class ChartRepository {
  Future<List<ChartData>> getEvolution() async {
    final response = await http.get(
      Uri.parse('$API_URL/charts/evolution'),
      headers: await headersWithToken(),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return (body["data"] as List)
          .map((meal) => ChartData.fromJson(meal))
          .toList();
    } else {
      errorService.currentResponseError = response;
      throw Exception();
    }
  }
}
