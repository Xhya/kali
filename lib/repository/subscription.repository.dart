import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kali/core/models/Subscription.model.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/headers.service.dart';
import 'package:kali/environment.dart';

class SubscriptionRepository {
  Future<List<SubscriptionModel>> getAll() async {
    final response = await http.get(
      Uri.parse('$API_URL/subscriptions'),
      headers: await headersWithMaybeToken(),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      final raw = body['data'] as List<dynamic>;
      return raw
          .map<SubscriptionModel>((e) => SubscriptionModel.fromJson(e))
          .toList();
    } else {
      errorService.currentResponseError = response;
      throw Exception();
    }
  }
}
