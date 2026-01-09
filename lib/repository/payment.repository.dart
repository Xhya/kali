import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kali/core/models/CreateSubscription.model.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/headers.service.dart';
import 'package:kali/environment.dart';

class PaymentRepository {
  Future<CreateSubscriptionModel> createIntent(String subscriptionId) async {
    Map body = {"subscriptionId": subscriptionId};

    final response = await http.post(
      Uri.parse('$API_URL/payments/intent'),
      headers: await headersWithMaybeToken(),
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return CreateSubscriptionModel.fromJson(body['data']);
    } else {
      errorService.currentResponseError = response;
      throw Exception();
    }
  }

  Future<void> createSubscription(String subscriptionId) async {
    Map body = {"subscriptionId": subscriptionId};

    final response = await http.post(
      Uri.parse('$API_URL/payments/subscription'),
      headers: await headersWithMaybeToken(),
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      return;
    } else {
      errorService.currentResponseError = response;
      throw Exception();
    }
  }
}
