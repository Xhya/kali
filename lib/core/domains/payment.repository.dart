import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/headers.service.dart';
import 'package:kali/environment.dart';

class PaymentRepository {
  Future<String> createIntent() async {
    final response = await http.post(
      Uri.parse('$API_URL/payments/intent'),
      headers: await headersWithMaybeToken(),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return body['data']['clientSecret'];
    } else {
      errorService.currentResponseError = response;
      throw Exception();
    }
  }
}
