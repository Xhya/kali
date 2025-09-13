import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kali/core/models/Feature.model.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/headers.service.dart';
import 'package:kali/environment.dart';

class FeatureRepository {
  Future<List<FeatureModel>> getNextFeatures() async {
    final response = await http.get(
      Uri.parse('$API_URL/features'),
      headers: await headersWithMaybeToken(),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return (body["data"] as List)
          .map((feature) => FeatureModel.fromJson(feature))
          .toList();
    } else {
      errorService.currentResponseError = response;
      throw Exception();
    }
  }

  Future<void> voteNextFeature({String? featureId}) async {
    final response = await http.post(
      Uri.parse('$API_URL/users/features/vote/$featureId'),
      headers: await headersWithMaybeToken(),
    );

    if (response.statusCode == 200) {
      return;
    } else {
      errorService.currentResponseError = response;
      throw Exception();
    }
  }
}
