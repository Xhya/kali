import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kali/core/models/Weight.model.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/headers.service.dart';
import 'package:kali/environment.dart';

class WeightRepository {
  Future<List<WeightModel>> getWeights() async {
    final response = await http.get(
      Uri.parse('$API_URL/weights'),
      headers: await headersWithToken(),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return (body["data"] as List)
          .map((item) => WeightModel.fromJson(item))
          .toList();
    } else {
      errorService.currentResponseError = response;
      throw Exception();
    }
  }

  Future<List<WeightModel>> addWeight({required double weight}) async {
    Map body = {"weight": weight.toDouble()};

    final response = await http.post(
      Uri.parse('$API_URL/weights'),
      headers: await headersWithToken(),
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return (body["data"] as List)
          .map((item) => WeightModel.fromJson(item))
          .toList();
    } else {
      errorService.currentResponseError = response;
      throw Exception();
    }
  }
}
