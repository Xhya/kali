import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/headers.service.dart';
import 'package:kali/environment.dart';

class PushNotificationRepository {
  Future<void> setNotificationToken(String token) async {
    final response = await http.patch(
      Uri.parse('$API_URL/users/fcm-token'),
      headers: await headersWithMaybeToken(),
      body: json.encode({"token": token}),
    );

    if (response.statusCode == 200) {
      return;
    } else {
      errorService.currentResponseError = response;
      throw Exception();
    }
  }
}
