import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kali/core/models/OperatingSystem.enum.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/headers.service.dart';
import 'package:kali/environment.dart';

class AuthenticationRepository {
  Future<void> initUser({
    required String currentVersion,
    required String currentBuild,
    required OperatingSystemEnum operatingSystem,
    required bool notificationActivated,
  }) async {
    Map body = {
      "currentVersion": currentVersion,
      "currentBuild": currentBuild,
      "operatingSystem": operatingSystem.label,
      "notificationActivated": notificationActivated,
    };

    final response = await http.post(
      Uri.parse('$API_URL/users/init'),
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

  Future<void> forgotPasswordRequest({required String email}) async {
    Map body = {"email": email};

    final response = await http.post(
      Uri.parse('$API_URL/forgot-password'),
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

  Future<void> updatePasswordRequest({
    required String newPassword,
    required String oldPassword,
  }) async {
    Map body = {"newPassword": newPassword, "oldPassword": oldPassword};

    final response = await http.patch(
      Uri.parse('$API_URL/users/update-password'),
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

  Future<void> initSignature({required String formattedSignature}) async {
    Map body = {"formattedSignature": formattedSignature};

    final response = await http.post(
      Uri.parse('$API_URL/users/init-signature'),
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

  Future<void> login({required String email, required String password}) async {
    Map body = {"email": email, "password": password};

    final response = await http.post(
      Uri.parse('$API_URL/users/login'),
      headers: await headersWithoutToken(),
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      final token = body["data"]["token"];
      await storeToken(token);
      return;
    } else {
      errorService.currentResponseError = response;
      throw Exception();
    }
  }

  Future<void> loginWithGoogle({
    required String email,
    required String authCode,
  }) async {
    Map body = {"email": email, "authCode": authCode};

    final response = await http.post(
      Uri.parse('$API_URL/users/login-google'),
      headers: await headersWithMaybeToken(),
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      await storeToken(authCode);
      return;
    } else {
      errorService.currentResponseError = response;
      throw Exception();
    }
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    Map body = {"email": email, "password": password};

    final response = await http.post(
      Uri.parse('$API_URL/users/register'),
      headers: await headersWithMaybeToken(),
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      final token = body["data"]["token"];
      await storeToken(token);
      return;
    } else {
      errorService.currentResponseError = response;
      throw Exception();
    }
  }

  Future<void> registerWithGoogle({
    required String email,
    required String authCode,
  }) async {
    Map body = {"email": email, "authCode": authCode};

    final response = await http.post(
      Uri.parse('$API_URL/users/register-google'),
      headers: await headersWithMaybeToken(),
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      await storeToken(authCode);
      return;
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

  Future<void> resendCode() async {
    final response = await http.post(
      Uri.parse('$API_URL/users/resend-code'),
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
