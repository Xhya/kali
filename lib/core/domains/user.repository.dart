import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/Headers.service.dart';
import 'package:kali/environment.dart';

class UserRepository {
  Future<void> register({
    required String email,
    required String password,
  }) async {
    Map body = {"email": email, "password": password};

    final response = await http.post(
      Uri.parse('$API_URL/users/register'),
      headers: await headersWithoutToken(),
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
