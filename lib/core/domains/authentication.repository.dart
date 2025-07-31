import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kali/core/models/OperatingSystem.enum.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/headers.service.dart';
import 'package:kali/environment.dart';

class AuthenticationRepository {
  Future<void> initUser({
    required String formattedSignature,
    required String currentVersion,
    required String currentBuild,
    required OperatingSystemEnum operatingSystem,
    required bool notificationActivated,
  }) async {
    Map body = {
      "formattedSignature": formattedSignature,
      "currentVersion": currentVersion,
      "currentBuild": currentVersion,
      "operatingSystem": operatingSystem.label,
      "notificationActivated": notificationActivated,
    };

    final response = await http.post(
      Uri.parse('$API_URL/users/init'),
      headers: await headersWithoutToken(),
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return body["data"];
    } else {
      errorService.currentResponseError = response;
      throw Exception();
    }
  }

  Future<void> verifyAuthCode({required String code}) async {
    Map body = {"code": code};

    final response = await http.post(
      Uri.parse('$API_URL/users/verify-code'),
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
